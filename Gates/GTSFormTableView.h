#import <UIKit/UIKit.h>

@class GTSElement;
@class GTSForm;

@interface GTSFormTableView : UITableView

- (NSIndexPath *)indexForElement:(GTSElement *)element;
- (UITableViewCell *)cellForElement:(GTSElement *)element;

- (GTSForm *)form;

@end
