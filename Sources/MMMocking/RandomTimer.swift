//
// MMMTemple.
// Copyright (C) 2019 MediaMonks. All rights reserved.
//

import Foundation

/// A repeating timer scheduling events with pseudo-random intervals.
///
/// It immediately schedules itself on the current run loop when created.
@available(iOS 10.0, *)
public class RandomTimer {

	public typealias Callback = () -> Void

	private let intervalRange: ClosedRange<TimeInterval>
	private var random: PseudoRandomSequence
	private let callback: Callback

	public init(intervalRange: ClosedRange<TimeInterval>, seed: Int, callback: @escaping Callback) {

		self.intervalRange = intervalRange
		self.random = PseudoRandomSequence(seed: seed)
		self.callback = callback

		scheduleNext()
	}

	deinit {
		timer?.invalidate()
	}

	private var timer: Timer?

	private func scheduleNext() {
		let interval = Double.random(in: intervalRange, using: &random)
		timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] (_) in
			self?.callback()
			self?.scheduleNext()
		}
	}
}
