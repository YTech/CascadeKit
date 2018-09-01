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

public extension String {
    /// Returns a list of CascadeFallback for a given list of Alphabets
    ///
    /// - Parameters:
    ///   - alphabets: A given list of Alphabets
    ///   - chars: A list of chars to be added even if not included in the input Alphabet list
    ///
    /// - Returns: A list of Fallback
    public func fallbackRanges(for alphabets: [Alphabet], including chars: [SpecialChar] = []) -> [Fallback] {
        var ranges: [Fallback] = []
        mapCascade(for: alphabets, including: chars) { fallback in
            ranges.append(fallback)
        }

        return ranges
    }

    /// Map CascadeFallback for a given list of Alphabets
    ///
    /// - Parameters:
    ///   - alphabets: A given list of Aphabets
    ///   - chars: A list of chars to be added even if not included in the input Alphabet list
    ///   - block: Emit the Fallback
    public func mapCascade(for alphabets: [Alphabet], including chars: [SpecialChar] = [], _ block: @escaping (Fallback) -> Void) {
        let transformedScalars = transform(for: alphabets, avoiding: chars)

        if transformedScalars.isEmpty { return }

        let storedBlock = { (fallback: Fallback) in
            block(fallback)
        }

        if transformedScalars.count == 1 {
            storedBlock(transformedScalars.first!)
        }

        emit(from: transformedScalars, block: storedBlock)
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

            let isWhitelisted = chars.contains { $0.rawValue == scalar.value }
            guard let match = scalar.match(in: alphabets, isWhitelisted: isWhitelisted) else {
                return nil
            }

            return Fallback(content: String(scalar), range: index...index, type: match, isWhitelisted: isWhitelisted)
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
        print("emit: --> ")
        guard var fallback = fallbacks.first else {
            return
        }

        fallbacks.dropFirst().forEach { currentFallback in
            print("emit: --> current fallback \(currentFallback)")

            guard let merged = fallback.merge(fallback: currentFallback) else {
                if !fallback.isWhitelisted {
                    print("emit: --> emitting the block --> \(fallback)")
                    block(fallback)
                }

                fallback = currentFallback
                print("emit: --> not merged --> \(fallback)")
                return
            }

            fallback = merged
            print("emit: --> merged --> \(fallback)")
        }

        print("emit: --> emitting the block --> \(fallback)")
        block(fallback)
    }
}
