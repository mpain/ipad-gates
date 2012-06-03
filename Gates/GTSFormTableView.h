#import <UIKit/UIKit.h>

@class GTSElement;

@interface GTSFormTableView : UITableView

- (NSIndexPath *)indexForElement:(GTSElement *)element;
- (UITableViewCell *)cellForElement:(GTSElement *)element;

@end
