# MMMocking

[![Build](https://github.com/mediamonks/MMMocking/workflows/Build/badge.svg)](https://github.com/mediamonks/MMMocking/actions?query=workflow%3ABuild)
[![Test](https://github.com/mediamonks/MMMocking/workflows/Test/badge.svg)](https://github.com/mediamonks/MMMocking/actions?query=workflow%3ATest)

Mock data using hip lorem ipsum and pseudo random numbers.

(This is a part of `MMMTemple` suite of iOS libraries we use at [MediaMonks](https://www.mediamonks.com/).)

## Installation

Podfile:

```ruby
source 'https://github.com/mediamonks/MMMSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'
...
pod 'MMMocking'
```

(Use 'MMMocking/ObjC' when Swift wrappers are not needed.)

SPM:

```swift
.package(url: "https://github.com/mediamonks/MMMocking", .upToNextMajor(from: "0.2.0"))
```

## Usage

`MMMocking` is a collection of helpers for generating useful mock data.

### MMMPseudoRandomSequence

A wrapper for a sequence of randomly looking integers that is convenient to use
for testing (so every sequence of pseudo-random events can be reproduced many
times). For non-test purposes use `arc4random()` and friends instead.

A seed can be set for the standard `rand()` function as well, but its usage cannot
be restricted to a single entity, so a sequence can be disrupted.

```swift
let random = MMMPseudoRandomSequence(seed: 1)

random.next() // Returns a "pseudo random" UInt64
random.nextBool() // Self explanatory, a random `true` or `false`
random.nextDouble() // A random double between 0 and 1.
random.nextInteger(in: 0...20) // A random integer between 0 and 20.
random.randomElement(of: ["a", "b", "c"]) // A random element in the array.

// Since it's pseudo random, if we start a new sequence with the same seed, we
// get the same results. So:
MMMPseudoRandomSequence(seed: 1).next() == MMMPseudoRandomSequence(seed: 1).next()
```

### PseudoRandomSequence

Seedable random number generator conforming to `RandomNumberGenerator` protocol.
Similar to `MMMPseudoRandomSequence` but `NSObject`-free.

### MMMHipsum

Very basic helpers for generation of test strings. Lorem ipsum inspired.

```swift
let hipsum = MMMHipsum(seed: 1)

// Returns an array of strings with at least 1 but at most 10 words.
hipsum.words(count: 1...10)

// Returns a sentence with 1 to 5 words.
hipsum.sentence(wordCount: 1...5)

// Returns a "Title Case String".
hipsum.titleCaseString(wordCount: 1...10)

// A paragraph with 2 to 7 sentences, with 2 to 7 words per sentence.
hipsum.paragraph(sentenceCount: 2...7, wordsPerSentence: 2...7)

// A full "body" text, with multiple paragraphs, sentences and words.
hipsum.text(
  paragraphCount: 2...12,
  sentencesPerParagraph: 2...7,
  wordsPerSentence: 5...20
)
```

### RandomTimer

A repeating timer scheduling events with pseudo-random intervals.

It immediately schedules itself on the current run loop when created.

```swift
self.timer = RandomTimer(intervalRange: 5...10, seed: 1) {
  // This get's called between 5 and 10 seconds, and will stop when deinitialized.
}
```

## Ready for liftoff? 🚀

We're always looking for talent. Join one of the fastest-growing rocket ships in
the business. Head over to our [careers page](https://media.monks.com/careers)
for more info!
