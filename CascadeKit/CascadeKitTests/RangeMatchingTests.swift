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

import XCTest
@testable import CascadeKit

class RangeMatchingTest: XCTestCase {
    func testMatchUnicodeScalar() {
        let type: Alphabet = ("a".unicodeScalars.first?.match(in: [.latin], isWhitelisted: false))!
        XCTAssertEqual(type, .latin)
    }

    func testUnmatchUnicodeScalar() {
        let type: Alphabet? = "a".unicodeScalars.first?.match(in: [.arabic], isWhitelisted: false)
        XCTAssertNil(type)
    }

    func testSpecialScalarMatchInDifferentAlphabet() {
        let type: Alphabet? = ("a".unicodeScalars.first?.match(in: [.arabic], isWhitelisted: true))
        XCTAssertNil(type)
    }

    func testSpecialScalarMatchInSameAlphabet() {
        let type: Alphabet? = ("a".unicodeScalars.first?.match(in: [.latin], isWhitelisted: true))
        XCTAssertNil(type)
    }

    func testFallbackMatching() {
        let expectation = self.expectation(description: "String matching")
        let sut = "hello"
        sut.mapCascade(for: [.latin, .russian]) {
            XCTAssertEqual($0.content, sut)
            XCTAssertEqual($0.range, 0...(sut.count - 1))
            XCTAssertEqual($0.type, .latin)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFallBackMatchingOnDifferentAlphabets() {
        let expectation = self.expectation(description: "String matching")
        let sut = "hello Етиам"

        var blockCounter = 0

        sut.mapCascade(for: [.latin, .russian]) {
            blockCounter += 1
            if blockCounter == 1 {
                XCTAssertEqual($0.content, "hello ")
                XCTAssertEqual($0.range, 0...5)
                XCTAssertEqual($0.type, .latin)
            } else if blockCounter == 2 {
                XCTAssertEqual($0.content, "Етиам")
                XCTAssertEqual($0.range, 6...10)
                XCTAssertEqual($0.type, .russian)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
