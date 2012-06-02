#import "GTSSection.h"
#import "GTSRowElement.h"

@implementation GTSSection {
	__strong NSMutableArray *sectionElements;
}

@synthesize title;

- (id)init {
	self = [super init];
	if (self) {
		sectionElements = [NSMutableArray array];
	}
	return self;
}

- (NSInteger) elementsCount {
	return [sectionElements count];
}

- (NSInteger) visibleElementCount {
	__block NSInteger visibleCount = 0;
	[sectionElements enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
		GTSRowElement *current = (GTSRowElement *)object;
		if (!current.hidden) {
			visibleCount++;
		}
	}];
	
	return visibleCount;
}

- (void)addElement:(GTSRowElement *)element {
	[sectionElements addObject:element];
}

@end
