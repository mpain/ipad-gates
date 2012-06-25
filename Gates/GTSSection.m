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

- (NSInteger)visibleIndexOfElement:(GTSRowElement *)element {
	__block NSInteger result = NSNotFound;
	__block NSInteger visibleIndex = 0;
	
	[self.elements enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
		GTSRowElement *current = (GTSRowElement *)object;
		if (!current.hidden) {
			if (current == element) {
				result = visibleIndex;
				*stop = YES;
			} else {
				visibleIndex++;
			}
		}
	}];
	
	return result;
}


- (GTSRowElement *)elementAtIndex:(NSInteger)index {
	__block GTSRowElement *result = nil;
	__block NSInteger visibleIndex = 0;
	
	[self.elements enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
		GTSRowElement *current = (GTSRowElement *)object;
		if (!current.hidden) {
			if (visibleIndex == index) {
				result = current;
				*stop = YES;
			} else {
				visibleIndex++;
			}
		}
	}];
	
	NSLog(@"section element at index: %d => %@", index, result);
	return result;
}

- (void)addElement:(GTSRowElement *)element {
    element.section = self;
	[self.elements addObject:element];
}

- (void)fetchValueIntoObject:(id)object {
    for (GTSRowElement *element in elements) {
        [element fetchValueIntoObject:(object)];
    }
}
@end
