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
