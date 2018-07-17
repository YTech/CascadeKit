//
//  Copyright © YOOX NET-A-PORTER 2018. All rights reserved.
//
import Foundation

public extension String {
    /// Returns a list of CascadeFallback for a given list of Alphabets
    ///
    /// - Parameters:
    ///   - alphabets: A given list of Alphabets
    ///   - chars: A list of carhs to avoid
    /// - Returns: A list of Fallback
    public func fallbackRanges(for alphabets: [Alphabet], avoiding chars: [SpecialChar] = []) -> [Fallback] {
        var ranges: [Fallback] = []
        mapCascade(for: alphabets, avoiding: chars) { fallback in
            ranges.append(fallback)
        }

        return ranges
    }

    /// Map CascadeFallback for a given list of Alphabets
    ///
    /// - Parameters:
    ///   - alphabets: A given list of Aphabets
    ///   - chars: A list of carhs to avoid
    ///   - block: Emit the Fallback
    public func mapCascade(for alphabets: [Alphabet], avoiding chars: [SpecialChar] = [], _ block: @escaping (Fallback) -> Void) {
        if Cache.shared.value(for: hashValue, block) {
            return
        }

        let transformedScalars = transform(for: alphabets, avoiding: chars)

        if transformedScalars.isEmpty { return }

        let storedBlock = { (fallback: Fallback) in
            Cache.shared.set(value: fallback, for: self.hashValue)
            block(fallback)
        }

        if transformedScalars.count == 1 {
            storedBlock(transformedScalars.first!)
        }

        emit(from: transformedScalars, block: storedBlock)
        Cache.shared.synchronize()
    }

    /// Returns a list of `Fallback` based on the input `alphabet`.
    /// Every Fallback will have a 1-spot range, the type based on the input `alphabet` and the identified scalar
    /// at that range.
    ///
    /// - Parameter alphabets: A collection of Alphabet
    /// - Returns: A list of Fallback
    private func transform(for alphabets: [Alphabet], avoiding chars: [SpecialChar]) -> [Fallback] {
        let transformedScalars = self.unicodeScalars.enumerated().compactMap { (arg) -> Fallback? in
            let (index, scalar) = arg

            let isSpecialChar = chars.contains { $0.rawValue == scalar.value }
            guard let match = scalar.match(in: alphabets, isSpecialChar: isSpecialChar) else {
                return nil
            }

            return Fallback(content: String(scalar), range: index...index, type: match, isSpecialChar: isSpecialChar)
        }

        return transformedScalars
    }

    /// Relies on the `Fallback.merge(:)` method which is able to merge to ranges into a bigger one.
    /// So everytime two ranges are consecutive, a new one is built with the composition of the two scalars
    /// and a range based on the union of the two ranges.
    ///
    /// - Parameters:
    ///   - fallbacks: A Fallback collection
    ///   - block: The block to emit passing the Fallback
    private func emit(from fallbacks: [Fallback], block: (Fallback) -> Void) {
        guard var fallback = fallbacks.first else {
            return
        }

        fallbacks.dropFirst().forEach { currentFallback in
            guard let merged = fallback.merge(fallback: currentFallback) else {
                if !fallback.isSpecialChar {
                    block(fallback)
                }
                fallback = currentFallback
                return
            }

            fallback = merged
        }

        block(fallback)
    }
}
