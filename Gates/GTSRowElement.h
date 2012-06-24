#import "GTSElement.h"

@class GTSFormCell;
@class GTSFormTableView;
@class GTSSection;
@protocol GTSElementDelegate;

@protocol GTSRowDelegate <NSObject>
@required
- (GTSFormCell *)getCellForTableView:(GTSFormTableView *)tableView;
- (NSString *)cellReusableIdentifier;
@end

@interface GTSRowElement : GTSElement<GTSRowDelegate>

@property (nonatomic, weak) GTSSection *section;
@property (nonatomic, weak) id<GTSElementDelegate> delegate;

@property (nonatomic, copy) NSString *fetchKey;

@end


