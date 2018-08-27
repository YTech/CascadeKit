// MIT License
//
// Copyright YOOX NET-A-PORTER (c) 2018
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
import Foundation

class Cache {
    static let shared = Stack<Int, Fallback>()
}

private struct StackConstant {
    static let archiveKey = "kCascadeStackArchiveKey"
}

class Stack<Key: Hashable, Value: Codable> {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let defaults = UserDefaults.standard
    private var values: [Key: [Data]] = [:]

    init() {
        restoreValues()
    }

    // MARK: Public methods
    func value(for key: Key, _ block:@escaping (Value) -> Void) -> Bool {
        guard let values = self.values[key], !values.isEmpty else {
            return false
        }

        var status = true
        for data in values {
            do {
                let value = try decoder.decode(Value.self, from: data)
                block(value)
            } catch {
                status = false
                break
            }
        }

        return status
    }

    func set(value: Fallback, for key: Key) {
        guard let data = try? encoder.encode(value) else {
            return
        }

        var values = self.values[key] ?? []
        values.append(data)

        if !values.isEmpty {
            self.values[key] = values
        }
    }

    func synchronize() {
        let data = NSKeyedArchiver.archivedData(withRootObject: values)
        defaults.set(data, forKey: StackConstant.archiveKey)
        defaults.synchronize()
    }

    func flush() {
        values.removeAll()
        synchronize()
    }

    // MARK: Private methods
    private func restoreValues() {
        if let data = defaults.object(forKey: StackConstant.archiveKey) as? Data {
            do {
                values = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Key: [Data]] ?? [:]
            } catch {
                values = [:]
            }
        }
    }
}
