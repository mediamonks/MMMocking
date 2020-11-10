//
// MMMocking. Part of MMMTemple suite.
// Copyright (C) 2016-2020 MediaMonks. All rights reserved.
//

extension MMMHipsum {
	
	/** An array of words with number of words being in the specified range, with the optional block which is called on each word. */
	open func words<R>(count range: R, processBlock: ((String) -> String)? = nil) -> [String]
		where R: RangeExpression, R.Bound: FixedWidthInteger
	{
		return words(count: NSRange(range), processBlock: processBlock)
	}

	/** A title case string without any punctuation. */
	open func titleCaseString<R>(wordCount range: R) -> String
		where R: RangeExpression, R.Bound: FixedWidthInteger
	{
		return titleCaseString(wordCount: NSRange(range))
	}
	
	open func sentenceFragment<R>(wordCount range: R) -> String
		where R: RangeExpression, R.Bound: FixedWidthInteger
	{
		return sentenceFragment(wordCount: NSRange(range))
	}
	
	/** A sentence with the word count within the given range. */
    open func sentence<R>(wordCount range: R) -> String
		where R: RangeExpression, R.Bound: FixedWidthInteger
	{
		return sentence(wordCount: NSRange(range))
	}
	
	open func paragraph<R>(sentenceCount: R, wordsPerSentence: R) -> String
		where R: RangeExpression, R.Bound: FixedWidthInteger
	{
		return paragraph(sentenceCount: NSRange(sentenceCount), wordsPerSentence: NSRange(wordsPerSentence))
	}
	
	open func text<R>(
		paragraphCount: R,
		sentencesPerParagraph: R,
		wordsPerSentence: R
	) -> String
		where R: RangeExpression, R.Bound: FixedWidthInteger
	{
	
		return text(
			paragraphCount: NSRange(paragraphCount),
			sentencesPerParagraph: NSRange(sentencesPerParagraph),
			wordsPerSentence: NSRange(wordsPerSentence)
		)
	}
}
