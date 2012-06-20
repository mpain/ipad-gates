#import <UIKit/UIKit.h>

@protocol GTSFormHeaderViewDelegate;

@interface GTSFormHeaderView : UIControl

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign, getter = isOpen) BOOL open;

@property (nonatomic, weak) id<GTSFormHeaderViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andSection:(NSInteger)section;

@end

@protocol GTSFormHeaderViewDelegate<NSObject>
@required
- (void)formHeaderView:(GTSFormHeaderView *)headerView sectionOpened:(NSInteger)section;
- (void)formHeaderView:(GTSFormHeaderView *)headerView sectionClosed:(NSInteger)section;

@end