#import "GTSEditableElement.h"
#import "GTSPickerParser.h"

@interface GTSPickerElement : GTSEditableElement

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, readonly, strong) NSArray *selectedItems;
@property (nonatomic, readonly, strong) NSArray *selectedIndices;
@property (nonatomic, strong) id<GTSPickerParser> valueParser;

- (id)initWithItems:(NSArray *)items value:(NSString *)value;


@end
