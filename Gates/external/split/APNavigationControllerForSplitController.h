#import <UIKit/UIKit.h>

@protocol APSplitViewDelegate;

@interface APNavigationControllerForSplitController : UINavigationController {
}

@property (nonatomic, weak, readonly) id<APSplitViewDelegate> splitDelegate;

- (id)initWithSplit:(id<APSplitViewDelegate>)splitDelegate;

@end