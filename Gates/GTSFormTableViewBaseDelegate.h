#import "GTSElement.h"

@class GTSFormTableView;

@protocol GTSFormBaseDelegate <NSObject>
- (GTSFormTableView *)convertToTableView:(UITableView *)aTableView;
@end

@interface GTSFormTableViewBaseDelegate : GTSElement<GTSFormBaseDelegate>

@end
