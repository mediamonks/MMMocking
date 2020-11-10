//
// MMMocking. Part of MMMTemple suite.
// Copyright (C) 2016-2020 MediaMonks. All rights reserved.
//

extension MMMHipsum {
	
	/** An array of words with number of words being in the specified range, with the optional block which is called on each word. */
	open func words(
		count range: ClosedRange<Int>,
		processBlock: ((String) -> String)? = nil
	) -> [String] {
	
		return words(count: NSRange(range), processBlock: processBlock)
	}

	/** A title case string without any punctuation. */
	open func titleCaseString(wordCount range: ClosedRange<Int>) -> String {
		return titleCaseString(wordCount: NSRange(range))
	}
	
	open func sentenceFragment(wordCount range: ClosedRange<Int>) -> String {
		return sentenceFragment(wordCount: NSRange(range))
	}
	
	/** A sentence with the word count within the given range. */
    open func sentence(wordCount range: ClosedRange<Int>) -> String {
		return sentence(wordCount: NSRange(range))
	}
	
	open func paragraph(
		sentenceCount: ClosedRange<Int>,
		wordsPerSentence: ClosedRange<Int>
	) -> String {
	
		return paragraph(
			sentenceCount: NSRange(sentenceCount),
			wordsPerSentence: NSRange(wordsPerSentence)
		)
	}
	
	open func text(
		paragraphCount: ClosedRange<Int>,
		sentencesPerParagraph: ClosedRange<Int>,
		wordsPerSentence: ClosedRange<Int>
	) -> String {
	
		return text(
			paragraphCount: NSRange(paragraphCount),
			sentencesPerParagraph: NSRange(sentencesPerParagraph),
			wordsPerSentence: NSRange(wordsPerSentence)
		)
	}
}
