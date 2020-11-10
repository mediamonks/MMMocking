//
// MMMocking. Part of MMMTemple suite.
// Copyright (C) 2016-2020 MediaMonks. All rights reserved.
//

extension MMMPseudoRandomSequence: RandomNumberGenerator {

	public func nextInteger(in range: ClosedRange<Int>) -> Int {
		return self.nextInteger(from: range.lowerBound, to: range.upperBound)
	}

	public func nextDouble(in range: ClosedRange<Double>) -> Double {
		return self.nextDouble(from: range.lowerBound, to: range.upperBound)
	}

	public func randomElement<T>(of array: Array<T>) -> T? {
		return array.count == 0 ? nil : array[self.nextInteger(from: 0, to: array.count - 1)]
	}

	// MARK: - RandomNumberGenerator

	public func next() -> UInt64 {
		return UInt64((UInt64(__next()) << 32) | UInt64(__next()))
	}

	// MARK: -
}

/// Seedable random number generator conforming to `RandomNumberGenerator` protocol.
/// Similar to `MMMPseudoRandomSequence` but `NSObject`-free.
public class PseudoRandomSequence: RandomNumberGenerator {

	private var last: UInt64

	public init(seed: Int) {

		self.last = UInt64(seed)

		// Discard a few values, so we don't begin too close to the seed.
		for _ in 1...7 {
			let _ = next()
		}
	}

	private func _next() -> UInt32 {
		// The multiplier and increment are from Turbo Pascal, see https://en.wikipedia.org/wiki/Linear_congruential_generator
		last = 134775813 &* last &+ 1
		return UInt32(truncatingIfNeeded: last >> 32)
	}

	public func next() -> UInt64 {
		return UInt64((UInt64(_next()) << 32) | UInt64(_next()))
	}
}
