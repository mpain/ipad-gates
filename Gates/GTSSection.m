#import "GTSSection.h"
#import "GTSRowElement.h"

@implementation GTSSection {
}

@synthesize title;
@synthesize form;
@synthesize elements;

- (id)init {
	self = [super init];
	if (self) {
		self.elements = [NSMutableArray array];
	}
	return self;
}

- (NSInteger) elementsCount {
	return [elements count];
}

- (NSInteger) visibleElementsCount {
	__block NSInteger visibleCount = 0;
	[self.elements enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
		GTSRowElement *current = (GTSRowElement *)object;
		if (!current.hidden) {
			visibleCount++;
		}
	}];
	
	return visibleCount;
}

- (void)addElement:(GTSRowElement *)element {
    element.section = self;
	[self.elements addObject:element];
}

@end
