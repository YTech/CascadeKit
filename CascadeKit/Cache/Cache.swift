//
//  Copyright © YOOX NET-A-PORTER 2018. All rights reserved.
//
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
