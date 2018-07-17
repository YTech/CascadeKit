//
//  Copyright © YOOX NET-A-PORTER 2018. All rights reserved.
//
import Foundation

public extension String {
    /// Create a substring using a Rangeable collection
    ///
    /// - Parameter collection: A collection
    /// - Returns: A string
    public func substring<C: Collection>(collection: C) -> String where C: Rangeable, C.Iterator.Element == Int {
        guard !collection.isEmpty, let first = collection.first else {
            fatalError("Collection must not be empty")
        }

        let range = interval(lowerBound: first, upperBound: (first + Int(collection.count)) - 1)
        return String(self[range.0...range.1])
    }

    /// Get an interval tuple from a bound
    ///
    /// - Parameters:
    ///   - lowerBound: The lower bound
    ///   - upperBound: The higher bound
    /// - Returns: a valid interval tuple
    private func interval(lowerBound: Int, upperBound: Int) -> (Index, Index) {
        return (index(startIndex, offsetBy: lowerBound), index(startIndex, offsetBy: upperBound))
    }
}
