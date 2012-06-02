#import "GTSElement.h"

@class GTSFormCell;
@class GTSFormTableView;

@protocol GTSRowDelegate <NSObject>
@required
- (GTSFormCell *)getCellForTableView:(GTSFormTableView *)tableView;
- (NSString *)cellReusableIdentifier;
@end

@interface GTSRowElement : GTSElement<GTSRowDelegate>

@end


