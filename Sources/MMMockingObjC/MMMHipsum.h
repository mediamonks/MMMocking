//
// MMMocking. Part of MMMTemple suite.
// Copyright (C) 2016-2020 MediaMonks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 
 * Very basic helpers for generation of test strings.
 */
@interface MMMHipsum : NSObject

/** Shared instance seeded with a random number, so it behaves as before adding a seed. */
+ (instancetype)shared;

- (id)init NS_UNAVAILABLE;

/** You can create a private instance seeded with a value you want so you get the same text for the same sequence of calls. */
- (id)initWithSeed:(NSInteger)seed NS_DESIGNATED_INITIALIZER;

/** The set of filler words. */
- (NSArray<NSString *> *)words;

/** An array of words with number of words being in the specified range, with the optional block which is called on each word. */
- (NSArray<NSString *> *)wordsWithCountInRange:(NSRange)range
	processBlock:(NSString * (NS_NOESCAPE ^ _Nullable)(NSString *s))processBlock
	NS_SWIFT_NAME(words(count:processBlock:));

/** A title case string without any punctuation. */
- (NSString *)titleCaseStringWithWordCountInRange:(NSRange)range
	NS_SWIFT_NAME(titleCaseString(wordCount:));

- (NSString *)sentenceFragmentWithWordCountInRange:(NSRange)range
	NS_SWIFT_NAME(sentenceFragment(wordCount:));

/** A sentence with the word count within the given range. */
- (NSString *)sentenceWithWordCountInRange:(NSRange)range
	NS_SWIFT_NAME(sentence(wordCount:));

- (NSString *)paragraphWithSentenceCountInRange:(NSRange)sentenceCountRange
	wordsPerSentenceInRange:(NSRange)wordsPerSentenceRange
	NS_SWIFT_NAME(paragraph(sentenceCount:wordsPerSentence:));

- (NSString *)textWithParagraphCountInRange:(NSRange)paragraphCountRange
	sentencesPerParagraphInRange:(NSRange)sentenceCountRange
	wordsPerSentenceInRange:(NSRange)wordsPerSentenceRange
	NS_SWIFT_NAME(text(paragraphCount:sentencesPerParagraph:wordsPerSentence:));

@end

NS_ASSUME_NONNULL_END
