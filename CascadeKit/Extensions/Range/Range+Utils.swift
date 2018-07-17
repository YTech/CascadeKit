//
//  Copyright © YOOX NET-A-PORTER 2018. All rights reserved.
//
import Foundation

/// Custom protocol used for constraining purpose
public protocol Rangeable { }

extension CountableClosedRange: Rangeable { }
extension CountableRange: Rangeable { }
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
