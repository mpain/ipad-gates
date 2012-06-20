#import "GTSFormHeaderView.h"
#import "GTSColors.h"

@implementation GTSFormHeaderView

@synthesize textLabel = _textLabel;
@synthesize section = _section;
@synthesize open = _open;

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame andSection:(NSInteger)section {
    self = [super initWithFrame:frame];
    if (self) {
		_section = section;
		_open = YES;

		[self createSubviews];
    }
    return self;
}

- (void)createSubviews {
	self.backgroundColor = [UIColor gtsTableHeaderBackgroundColor];
	
	CGRect labelFrame = CGRectInset(self.bounds, 15, 15);
	_textLabel = [[UILabel alloc] initWithFrame:labelFrame];
	_textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
	_textLabel.backgroundColor = [UIColor clearColor];
	_textLabel.textColor = [UIColor whiteColor];
	
	[self  addSubview:_textLabel];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.delegate) {
		return;
	}
	
	self.open = !self.isOpen;
	
	if (self.isOpen) {
		[self.delegate formHeaderView:self sectionOpened:_section];
	} else {
		[self.delegate formHeaderView:self sectionClosed:_section];
	}
}

@end
