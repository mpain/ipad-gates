#import "GTSFormHeaderView.h"
#import "GTSColors.h"

@implementation GTSFormHeaderView

@synthesize imageView = _imageView;
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
	
	CGRect labelFrame = CGRectInset(self.bounds, 40, 5);
	_textLabel = [[UILabel alloc] initWithFrame:labelFrame];
	_textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
	_textLabel.backgroundColor = [UIColor clearColor];
	_textLabel.textColor = [UIColor whiteColor];
	[self addSubview:_textLabel];
	
	CGRect imageFrame = CGRectMake(10, (self.bounds.size.height - 20.0f) / 2.0f, 20, 20);
	_imageView = [[UIImageView alloc] initWithFrame:imageFrame];
	_imageView.image = [UIImage imageNamed:@"arrow-down.png"];
	
	[self addSubview:_imageView];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.delegate) {
		return;
	}
	
	self.open = !self.isOpen;
	[self updateArrow];
	if (self.isOpen) {
		[self.delegate formHeaderView:self sectionOpened:_section];
	} else {
		[self.delegate formHeaderView:self sectionClosed:_section];
	}
}

- (void)updateArrow {
	__block GTSFormHeaderView *myself = self;
	
	[UIView animateWithDuration:0.2f animations:^{
		CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI * ((myself.open) ? 0.0 : 1.0f));
		myself.imageView.transform = transform;
	} completion:^(BOOL finished) {
		myself = nil;
	}];
}

@end
