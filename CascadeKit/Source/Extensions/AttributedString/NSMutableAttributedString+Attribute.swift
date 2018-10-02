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

public extension NSMutableAttributedString {
    typealias FallBackHandler = (Fallback) -> [Attribute]
    /// Modify the attribute handling the Fallback attributes
    ///
    /// - Parameters:
    ///   - alphabets: A collection of Alphabet
    ///   - chars: A collection of special chars
    ///   - block: Returns the Attributes for the current fallback

    /// - Returns: A mutable attribute string
    @discardableResult
    public func addAttributes(for alphabets: [Alphabet], including chars: [SpecialChar] = [], _ block: @escaping FallBackHandler) -> NSMutableAttributedString {
        string.mapCascade(for: alphabets, including: chars) { [weak self] (fallback) in
            let attributes = block(fallback)

            attributes.forEach {
                self?.addAttribute($0.key, value: $0.value, range: $0.range)
            }
        }

        return self
    }

    /// Add an attribute to a NSMutableAttributedString passing a CountableClosedRange<Int>
    ///
    /// - Parameters:
    ///   - name: NSAttributedStringKey key value
    ///   - value: A value for the attribute
    ///   - range: A valid CountableClosedRange<Int>
    #if !swift(>=4.2)
    public func addAttribute(_ name: NSAttributedStringKey, value: Any, range: CountableClosedRange<Int>) {
        guard let start = Array(range).first, let last = Array(range).last else {
            return
        }

        addAttribute(name, value: value, range: NSRange(location: start, length: last - start + 1))
    }
    #else
    public func addAttribute(_ name: NSAttributedString.Key, value: Any, range: CountableClosedRange<Int>) {
        guard let start = Array(range).first, let last = Array(range).last else {
            return
        }

        addAttribute(name, value: value, range: NSRange(location: start, length: last - start + 1))
    }
    #endif
}
