//
// MMMocking. Part of MMMTemple suite.
// Copyright (C) 2016-2020 MediaMonks. All rights reserved.
//

import XCTest
@testable import MMMocking

class MMMHipsumTestCase: XCTestCase {

	func testWords() {
		
		let hipsum = MMMHipsum(seed: 1)
		let words = hipsum.words(count: 4...4)
		
		XCTAssertEqual(words.count, 4)
		
		let range = hipsum.words(count: 1...10)
		
		XCTAssert(range.count > 0)
		XCTAssert(range.count <= 10)
	}
	
	// Make sure the swift RangeExpresion helpers work as expected.
	func testRangeExpressions() {
		
		let hipsum = MMMHipsum(seed: 1)
		let hipsum2 = MMMHipsum(seed: 1)
		
		XCTAssertEqual(
			hipsum.words(count: 0...5),
			hipsum2.words(count: NSMakeRange(0, 5))
		)
		
		XCTAssertEqual(
			hipsum.sentence(wordCount: NSMakeRange(0, 5)),
			hipsum2.sentence(wordCount: 0...5)
		)
		
		XCTAssertEqual(
			hipsum.sentenceFragment(wordCount: 0...10),
			hipsum2.sentenceFragment(wordCount: NSMakeRange(0, 10))
		)
		
		XCTAssertEqual(
			hipsum.titleCaseString(wordCount: 0...10),
			hipsum2.titleCaseString(wordCount: NSMakeRange(0, 10))
		)
		
		XCTAssertEqual(
			hipsum.paragraph(sentenceCount: 2...5, wordsPerSentence: 2...5),
			hipsum2.paragraph(sentenceCount: NSMakeRange(2, 7), wordsPerSentence: NSMakeRange(2, 7))
		)
		
		XCTAssertEqual(
			hipsum.text(
				paragraphCount: 2...10,
				sentencesPerParagraph: 2...5,
				wordsPerSentence: 5...20
			),
			hipsum2.text(
				paragraphCount: NSMakeRange(2, 12),
				sentencesPerParagraph: NSMakeRange(2, 7),
				wordsPerSentence: NSMakeRange(5, 25)
			)
		)
		
		XCTAssertEqual(
			hipsum.sentence(wordCount: NSMakeRange(5, 5)),
			hipsum2.sentence(wordCount: 5...10)
		)
	}
	
}
