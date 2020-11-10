//
// MMMocking. Part of MMMTemple suite.
// Copyright (C) 2016-2020 MediaMonks. All rights reserved.
//

import XCTest
@testable import MMMocking

class MMMPseudoRandomSequenceTestCase: XCTestCase {
	
	// Since it's pseudo random, the same seed should produce the same result.
	func testBasics() {
		
		let random1 = MMMPseudoRandomSequence(seed: 1)
		let random2 = MMMPseudoRandomSequence(seed: 1)
		
		XCTAssertEqual(random1.next(), random2.next())
	}
	
	func testNewBasics() {
		
		var newRandom1 = PseudoRandomSequence(seed: 1)
		var newRandom2 = PseudoRandomSequence(seed: 1)
		
		XCTAssertEqual(newRandom1.next(), newRandom2.next())
		
		XCTAssertEqual(
			newRandom1.next(upperBound: UInt(5)),
			newRandom2.next(upperBound: UInt(5))
		)
	}
	
}
