#import <UIKit/UIKit.h>

@protocol GTSPageScrollViewDatasource;

@interface GTSPageScrollView : UIView<UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, unsafe_unretained) IBOutlet id<GTSPageScrollViewDatasource> dataSource;

- (void)reload;

@end

@protocol GTSPageScrollViewDatasource<NSObject>

@required
- (UIView*) pageScrollView:(GTSPageScrollView *)pageScrollView viewForPageAtIndex:(NSInteger)index;

@optional
- (NSInteger)numberOfPagesInScrollView:(GTSPageScrollView *)pageScrollView;

@end

