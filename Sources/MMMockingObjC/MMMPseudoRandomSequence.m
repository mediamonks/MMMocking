//
// MMMocking. Part of MMMTemple suite.
// Copyright (C) 2016-2020 MediaMonks. All rights reserved.
//

#import "MMMPseudoRandomSequence.h"

@implementation MMMPseudoRandomSequence {
	uint64_t _last;
}

- (id)initWithSeed:(NSInteger)seed {

	if (self = [super init]) {

		_last = (uint32_t)seed;

		// Let's discard a few values because we can.
		for (NSInteger i = 0; i < 7; i++) {
			[self next];
		}
	}
	return self;
}

- (uint32_t)next {
	// The multiplier and increment are from Turbo Pascal, see https://en.wikipedia.org/wiki/Linear_congruential_generator
	_last = 134775813 * _last + 1;
	return (_last >> 32);
}

- (double)nextDouble {
	return [self next] / (double)0xFFFFFFFF;
}

- (id)nextRandomElementOfArray:(NSArray *)array {
	return array[[self nextIntegerFrom:0 to:array.count - 1]];
}

- (BOOL)nextBool {
	// Trying to not use the last bit as it might be of bad quality in a generator like this.
	return ([self next] & 0x10) != 0;
}

- (NSInteger)nextIntegerFrom:(NSInteger)from to:(NSInteger)to {
	// Doing this via nextDouble is better than truncating 'next' modulo (to - from).
	return round(from + [self nextDouble] * (to - from));
}

- (double)nextDoubleFrom:(double)from to:(double)to {
	return from + [self nextDouble] * (to - from);
}

- (NSArray *)shuffledArray:(NSArray *)array {

	NSMutableArray *result = [[NSMutableArray alloc] initWithArray:array];
	NSInteger numberOfSwaps = [self nextIntegerFrom:array.count to:2 * array.count];
	for (NSInteger i = 0; i < numberOfSwaps; i++) {
		NSInteger index1 = [self nextIntegerFrom:0 to:array.count - 1];
		NSInteger index2 = [self nextIntegerFrom:0 to:array.count - 1];
		[result exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
	}

	return result;
}

@end
