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

/// Attribute struct to decorate an attribute string
public struct Attribute {
    #if swift(>=4.2)
    public 	typealias NSAttributedStringKey = NSAttributedString.Key
    #endif

    public var key: NSAttributedStringKey
    public var value: Any
    public var range: CountableClosedRange<Int>

    #if !swift(>=4.2)
    public init(key: NSAttributedStringKey, value: Any, range: CountableClosedRange<Int>) {
        self.key = key
        self.value = value
        self.range = range
    }
    #else
    public init(key: NSAttributedString.Key, value: Any, range: CountableClosedRange<Int>) {
        self.key = key
        self.value = value
        self.range = range
    }
    #endif
}
