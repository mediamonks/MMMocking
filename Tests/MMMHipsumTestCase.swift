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
		
		let range = hipsum.words(count: 1..<10)
		
		XCTAssert(range.count > 0)
		XCTAssert(range.count < 10)
	}
	
	// Make sure the swift RangeExpresion helpers work as expected.
	func testRangeExpressions() {
		
		let hipsum = MMMHipsum(seed: 1)
		let hipsum2 = MMMHipsum(seed: 1)
		
		XCTAssertEqual(
			hipsum.words(count: 0..<5),
			hipsum2.words(count: NSMakeRange(0, 5))
		)
		
		XCTAssertEqual(
			hipsum.sentence(wordCount: NSMakeRange(0, 5)),
			hipsum2.sentence(wordCount: 0..<5)
		)
		
		XCTAssertEqual(
			hipsum.sentenceFragment(wordCount: 0..<10),
			hipsum2.sentenceFragment(wordCount: NSMakeRange(0, 10))
		)
		
		XCTAssertEqual(
			hipsum.titleCaseString(wordCount: 0..<10),
			hipsum2.titleCaseString(wordCount: NSMakeRange(0, 10))
		)
		
		XCTAssertEqual(
			hipsum.paragraph(sentenceCount: 0..<5, wordsPerSentence: 0..<5),
			hipsum2.paragraph(sentenceCount: NSMakeRange(0, 5), wordsPerSentence: NSMakeRange(0, 5))
		)
		
		XCTAssertEqual(
			hipsum.text(
				paragraphCount: 0..<10,
				sentencesPerParagraph: 0..<5,
				wordsPerSentence: 0..<20
			),
			hipsum2.text(
				paragraphCount: NSMakeRange(0, 10),
				sentencesPerParagraph: NSMakeRange(0, 5),
				wordsPerSentence: NSMakeRange(0, 20)
			)
		)
		
		XCTAssertEqual(
			hipsum.sentence(wordCount: NSMakeRange(5, 5)),
			hipsum2.sentence(wordCount: 5..<10)
		)
	}
	
}
