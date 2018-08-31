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

/// Custom protocol used for constraining purpose
public protocol Rangeable { }

#if !swift(>=3.4) || (swift(>=4) && !swift(>=4.1.5))
extension CountableClosedRange: Rangeable { }
extension CountableRange: Rangeable { }
#endif

extension ClosedRange: Rangeable { }
extension Range: Rangeable { }

/// Make a CountableClosedRange conform to Codable
extension CountableClosedRange: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rangeDescription = try container.decode(String.self)
        let rangeElements = rangeDescription.components(separatedBy: "...")

        guard rangeElements.count == 2 else {
            throw DecodingError.dataCorruptedError("\"\(rangeDescription)\": invalid closed range expression")
        }

        guard let l = rangeElements.first.flatMap({ Int($0) }) as? Bound,
            let u = rangeElements.last.flatMap({ Int($0) }) as? Bound else {
                throw DecodingError.dataCorruptedError("\"\(rangeDescription)\": composed by non-int bounds")
        }

        self.init(uncheckedBounds: (lower: l, upper: u))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode("\(lowerBound)...\(upperBound)")
    }
}
