#import "GTSLabelCell.h"

@class GTSLabelInfoElement;

@interface GTSLabelInfoCell : GTSLabelCell

@property(nonatomic, strong) IBOutlet UILabel *labelInfo;
@property (nonatomic, weak) GTSLabelInfoElement *element;

- (void)updateCellFromElement:(GTSLabelInfoElement *)anElement;
- (void)updateInfoFromElement;
@end
