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

/// Alphabet types
public enum Alphabet: String, Codable {
    case arabic
    case greek
    case greekExtended
    case latin
    case latinSupplementary
    case myanmar
    case russian
    case russianSupplementary

    /// A valid CountableClosedRange<UInt32> based on Self
    public var range: CountableClosedRange<UInt32> {
        switch self {
        case .arabic: return 0x600...0x6FF
        case .greek: return 0x370...0x3FF
        case .greekExtended: return 0x1F00...0x1FFF
        case .latin: return 0x20...0x7F
        case .latinSupplementary: return 0xA0...0xFF
        case .myanmar: return 0x1000...0x109F
        case .russian: return 0x400...0x4FF
        case .russianSupplementary: return 0x500...0x52F
        }
    }
}

//Special chars
public enum SpecialChar: UInt32 {
    case whiteSpace = 32
}
