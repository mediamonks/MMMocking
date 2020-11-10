//
// MMMocking. Part of MMMTemple suite.
// Copyright (C) 2016-2020 MediaMonks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A wrapper for a sequence of randomly looking integers that is convenient to use for testing (so every sequence of
 * pseudo-random events can be reproduced many times). For non-test purposes use arc4random() and friends instead.
 *
 * A seed can be set for the standard rand() function as well, but its usage cannot be restricted to a single entity,
 * so a sequence can be disrupted.
 */
@interface MMMPseudoRandomSequence : NSObject

- (id)initWithSeed:(NSInteger)seed NS_DESIGNATED_INITIALIZER;
- (id)init NS_UNAVAILABLE;

/** A value from [0; 0xFFFFFFFF] range. */
- (uint32_t)next NS_REFINED_FOR_SWIFT;

// Convenience methods based on `next`, i.e. their resolution is never going to be better than 32 bits.

/** A double value from [0; 1] range. */
- (double)nextDouble;

/** A boolean with equal probabilities between `true` and `false`. */
- (BOOL)nextBool;

/** An integer value from the [from; to] range. */
- (NSInteger)nextIntegerFrom:(NSInteger)from to:(NSInteger)to;

/** A double value from the [from; to] range. */
- (double)nextDoubleFrom:(double)from to:(double)to;

/** A random element from the given array. */
- (nullable id)nextRandomElementOfArray:(NSArray *)array NS_SWIFT_UNAVAILABLE("Use randomElement(of:)");

/** Shuffled version of the given array using the random numbers from the receiver. */
- (NSArray *)shuffledArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
