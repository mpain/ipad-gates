#import "GTSElement.h"

@class GTSForm;
@class GTSRowElement;

@interface GTSSection : GTSElement

@property (nonatomic, strong) NSMutableArray *elements;
@property (nonatomic, weak) GTSForm *form;
@property (nonatomic, strong) NSString *title;

- (NSInteger) elementsCount;
- (NSInteger) visibleElementsCount;
- (void)addElement:(GTSRowElement *)element;
@end
