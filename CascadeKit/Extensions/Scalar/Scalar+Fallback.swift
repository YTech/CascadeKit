//
//  Copyright © YOOX NET-A-PORTER 2018. All rights reserved.
//
import Foundation

public extension Unicode.Scalar {
    /// Match the unicode scalar within the alphabet range
    ///
    /// - Parameters:
    ///   - alphabets: A collection of Alphabet
    ///   - isSpecialChar: If the scalar is a special char, it's returned straightaway, instead of
    ///                    performing a match
    /// - Returns: An Alphabet if exists
    public func match(in alphabets: [Alphabet], isSpecialChar: Bool) -> Alphabet? {
        guard
            !isSpecialChar,
            !alphabets.isEmpty,
            let firstRange = alphabets.first else {

            return nil
        }

        if firstRange.range ~= value { return firstRange }

        return match(in: Array(alphabets.dropFirst()), isSpecialChar: isSpecialChar)
    }
}
