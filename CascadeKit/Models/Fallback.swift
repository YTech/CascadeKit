//
//  Copyright © YOOX NET-A-PORTER 2018. All rights reserved.
//
import Foundation

/// String cascade fallback
public struct Fallback: Codable {
    public let content: String
    public let range: CountableClosedRange<Int>
    public let type: Alphabet
    public let isSpecialChar: Bool
}

public extension Fallback {
    /// Create a new fallback from a given Fallback
    ///
    /// - Parameter fallback: A valid Fallback
    /// - Returns: A new Fallback if exists
    public func merge(fallback: Fallback) -> Fallback? {
        if range.upperBound != (fallback.range.lowerBound - 1) {
            return nil
        }

        return Fallback(content: content + fallback.content,
                        range: range.lowerBound...fallback.range.upperBound,
                        type: fallback.type,
                        isSpecialChar: fallback.isSpecialChar)
    }
}
