#import <UIKit/UIKit.h>
#import "GTSPageScrollView.h"

@interface GTSPdfViewController : UIViewController<GTSPageScrollViewDatasource>

@property (nonatomic, copy) NSString *documentName;
@end
