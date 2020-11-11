//
// MMMocking. Part of MMMTemple suite.
// Copyright (C) 2016-2020 MediaMonks. All rights reserved.
//

import XCTest
@testable import MMMocking

class MMMHipsumTestCase: XCTestCase {

	func testWords() {
		
		let hipsum = MMMHipsum(seed: Int.random(in: 0...10000))
		
		let range = hipsum.words(count: 1...10)
		
		XCTAssertEqual(NSRange(1...10), NSMakeRange(1, 10))
		XCTAssert(range.count > 0)
		XCTAssert(range.count <= 10)
	}
	
	func testSentence() {
		
		let hipsum = MMMHipsum(seed: Int.random(in: 0...10000))
		let words = hipsum.sentence(wordCount: 2...7).split(separator: " ")
		
		// We want somewhere from 2 to 7 words.
		XCTAssert(words.count >= 2)
		XCTAssert(words.count <= 8)
	}
	
	// Make sure the swift RangeExpresion helpers work as expected.
	func testRangeExpressions() {
		
		let hipsum = MMMHipsum(seed: 1)
		let hipsum2 = MMMHipsum(seed: 1)
		
		XCTAssertEqual(
			hipsum.words(count: 1...5),
			hipsum2.words(count: NSMakeRange(1, 5))
		)
		
		XCTAssertEqual(
			hipsum.sentence(wordCount: NSMakeRange(1, 5)),
			hipsum2.sentence(wordCount: 1...5)
		)
		
		XCTAssertEqual(
			hipsum.sentenceFragment(wordCount: 1...10),
			hipsum2.sentenceFragment(wordCount: NSMakeRange(1, 10))
		)
		
		XCTAssertEqual(
			hipsum.titleCaseString(wordCount: 1...10),
			hipsum2.titleCaseString(wordCount: NSMakeRange(1, 10))
		)
		
		XCTAssertEqual(
			hipsum.paragraph(sentenceCount: 2...7, wordsPerSentence: 2...7),
			// Since ClosedRange(2...7) == (2,3,4,5,6,7), the NSRange equivalent is
			// loc: 2, len: 6; starting at 2 and creating a range of 6 integers (2,3,4,5,6,7).
			hipsum2.paragraph(sentenceCount: NSMakeRange(2, 6), wordsPerSentence: NSMakeRange(2, 6))
		)
		
		// Look at the comments on the paragraph assert for info on 2...12 / NSMakeRange(2,11) etc.
		XCTAssertEqual(
			hipsum.text(
				paragraphCount: 2...12,
				sentencesPerParagraph: 2...7,
				wordsPerSentence: 5...20
			),
			hipsum2.text(
				paragraphCount: NSMakeRange(2, 11),
				sentencesPerParagraph: NSMakeRange(2, 6),
				wordsPerSentence: NSMakeRange(5, 16)
			)
		)
		
		XCTAssertEqual(
			hipsum.sentence(wordCount: NSMakeRange(5, 6)),
			hipsum2.sentence(wordCount: 5...10)
		)
	}
}
