//
// MMMocking. Part of MMMTemple suite.
// Copyright (C) 2016-2020 MediaMonks. All rights reserved.
//

#import "MMMHipsum.h"

#import "MMMPseudoRandomSequence.h"

@implementation MMMHipsum {
	MMMPseudoRandomSequence *_random;
}

static MMMHipsum *sharedInstance = nil;

+ (instancetype)shared {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] initWithSeed:arc4random()];
	});
	return sharedInstance;
}

- (id)initWithSeed:(NSInteger)seed {
	if (self = [super init]) {
		_random = [[MMMPseudoRandomSequence alloc] initWithSeed:seed];
	}
	return self;
}

- (NSArray *)words {

	static dispatch_once_t onceToken;
	static NSArray *result;
	dispatch_once(&onceToken, ^{
		// Taken from https://gist.github.com/boogah/2e880e0f99823a84f61d#file-hipsum_neat-csv and edited a bit.
		result = @[
			@"+1", @"8-bit", @"90's", @"actually", @"aesthetic", @"art party", @"artisan", @"asymmetrical", @"Austin",
			@"authentic", @"banh mi", @"banjo", @"beard", @"before they sold out", @"bespoke", @"bicycle rights",
			@"biodiesel", @"bitters", @"blog", @"Brooklyn", @"brunch", @"butcher", @"cardigan", @"chambray", @"chia",
			@"chillwave", @"cliche", @"Cosby sweater", @"craft beer", @"cray", @"crucifix", @"direct trade ",
			@"disrupt", @"distillery", @"DIY", @"dreamcatcher", @"drinking vinegar", @"Echo Park", @"ennui", @"ethical",
			@"Etsy", @"fanny pack", @"farm-to-table", @"fashion axe", @"fingerstache", @"fixie", @"flannel",
			@"food truck", @"forage", @"four loko", @"freegan", @"gastropub", @"gentrify", @"gluten-free", @"Godard",
			@"hashtag", @"heirloom", @"hella", @"Helvetica", @"High Life", @"hoodie", @"Intelligentsia", @"irony",
			@"jean shorts", @"kale chips", @"keffiyeh", @"keytar", @"Kickstarter", @"kitsch", @"kogi", @"leggings",
			@"letterpress", @"literally", @"lo-fi", @"locavore", @"lomo", @"meggings", @"meh", @"messenger bag",
			@"mixtape", @"mlkshk", @"mumblecore", @"mustache", @"narwhal", @"Neutra", @"next level", @"normcore",
			@"occupy", @"Odd Future", @"organic", @"paleo", @"photo booth", @"pickled", @"Pinterest", @"Pitchfork",
			@"plaid", @"polaroid", @"pop-up", @"pork belly", @"Portland", @"post-ironic", @"pour-over", @"pug",
			@"put a bird on it", @"quinoa", @"raw denim", @"readymade", @"retro", @"roof party", @"salvia",
			@"sartorial", @"scenester", @"Schlitz", @"seitan", @"selfies", @"selvage", @"semiotics", @"shabby chic",
			@"single-origin", @"skateboard", @"slow-carb", @"small batch", @"squid", @"sriracha", @"street art",
			@"stumptown", @"sustainable", @"swag", @"synth", @"tattooed", @"Thundercats", @"tofu", @"tote bag",
			@"tousled", @"trust fund", @"try-hard", @"typewriter", @"ugh", @"umami", @"vegan", @"VHS", @"Vice",
			@"vinyl", @"viral", @"wayfarers", @"whatever", @"Williamsburg", @"wolf", @"XOXO", @"YOLO",
			@"you probably haven't heard of them", @"yr"
		];
	});
	return result;
}

- (NSInteger)nextIntegerFromRange:(NSRange)range {
	return [_random nextIntegerFrom:range.location to:range.location + range.length];
}

- (NSArray *)wordsWithCountInRange:(NSRange)range
	processBlock:(NSString * (NS_NOESCAPE ^ _Nullable)(NSString *s))processBlock
{
	NSInteger count = [self nextIntegerFromRange:range];
	NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:count];
	NSArray *words = [self words];
	for (NSInteger i = 0; i < count; i++) {

		NSString *word = [_random nextRandomElementOfArray:words];

		if (processBlock)
			word = processBlock(word);

		[result addObject:word];
	}

	return result;
}

- (NSString *)titleCaseStringWithWordCountInRange:(NSRange)range {

	NSArray *words = [self
		wordsWithCountInRange:range
		processBlock:^NSString *(NSString *s) {
			return [s capitalizedString];
		}
	];

	return [words componentsJoinedByString:@" "];
}

- (NSString *)sentenceFragmentWithWordCountInRange:(NSRange)range {

	NSArray *words = [self wordsWithCountInRange:range processBlock:nil];

	return [words componentsJoinedByString:@" "];
}

- (NSString *)sentenceWithWordCountInRange:(NSRange)range {

	NSMutableArray *words = [[self wordsWithCountInRange:range processBlock:nil] mutableCopy];

	if (words.count > 0)
		words[0] = [words[0] capitalizedString];

	return [[words componentsJoinedByString:@" "] stringByAppendingString:@"."];
}

- (NSString *)paragraphWithSentenceCountInRange:(NSRange)sentenceCountRange
	wordsPerSentenceInRange:(NSRange)wordsPerSentenceRange
{
	NSInteger sentenceCount = [self nextIntegerFromRange:sentenceCountRange];
	NSMutableArray *sentences = [[NSMutableArray alloc] initWithCapacity:sentenceCount];
	for (NSInteger i = 0; i < sentenceCount; i++) {
		[sentences addObject:[self sentenceWithWordCountInRange:wordsPerSentenceRange]];
	}
	return [sentences componentsJoinedByString:@" "];
}

- (NSString *)textWithParagraphCountInRange:(NSRange)paragraphCountRange
	sentencesPerParagraphInRange:(NSRange)sentenceCountRange
	wordsPerSentenceInRange:(NSRange)wordsPerSentenceRange
{
	NSInteger paragraphCount = [self nextIntegerFromRange:paragraphCountRange];
	NSMutableArray *paragraphs = [[NSMutableArray alloc] initWithCapacity:paragraphCount];
	for (NSInteger i = 0; i < paragraphCount; i++) {
		[paragraphs addObject:[self
			paragraphWithSentenceCountInRange:sentenceCountRange
			wordsPerSentenceInRange:wordsPerSentenceRange
		]];
	}
	return [paragraphs componentsJoinedByString:@"\n"];
}

@end
