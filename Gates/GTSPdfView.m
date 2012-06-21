#import "GTSPdfView.h"

@implementation GTSPdfView {
    CGPDFPageRef _pdfPage;
    CGFloat _scale;
	CGSize _offset;
}

//+ (Class)layerClass {
//    return [CATiledLayer class];
//}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self createTiledLayer];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
    if (self) {
        [self createTiledLayer];
    }
    return self;
}

- (void)createTiledLayer {
//	CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
//	tiledLayer.levelsOfDetail = 4;
//	tiledLayer.levelsOfDetailBias = 3;
//	tiledLayer.tileSize = CGSizeMake(512.0, 512.0);
}

- (void)setPage:(CGPDFPageRef)newPage {
    CGPDFPageRelease(_pdfPage);
    _pdfPage = CGPDFPageRetain(newPage);
}

- (void)drawRect:(CGRect)rect {
}

- (void)layoutSubviews {
	CGRect pageRect = CGPDFPageGetBoxRect(_pdfPage, kCGPDFMediaBox);
	CGFloat kOffsetX = 0;//20;
	CGFloat kOffsetY = 0;//70;
	
	CGRect bounds = self.superview.bounds;
	
	pageRect = CGRectInset(pageRect, kOffsetX, kOffsetY);
	CGFloat scaleY = bounds.size.height / pageRect.size.height;
	CGFloat scaleX = bounds.size.width / pageRect.size.width;
	
	CGSize sizeScaledX = CGSizeApplyAffineTransform(pageRect.size, CGAffineTransformMakeScale(scaleX, scaleX));
	CGSize sizeScaledY = CGSizeApplyAffineTransform(pageRect.size, CGAffineTransformMakeScale(scaleY, scaleY));
	
	BOOL isScaledByY = sizeScaledX.height > bounds.size.height;
	_scale = isScaledByY ? scaleY : scaleX;
	CGSize size = isScaledByY ? sizeScaledY : sizeScaledX;
	
	_offset = CGSizeMake(kOffsetX, kOffsetY);
	self.frame = CGRectMake((bounds.size.width - size.width) / 2, (bounds.size.height - size.height) / 2, size.width, size.height);
}

- (void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context {
	[self layoutSubviews];
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, self.bounds);
    
    CGContextSaveGState(context);
    
	CGContextTranslateCTM(context, -fabs(_offset.width), self.bounds.size.height + fabs(_offset.height));
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextScaleCTM(context, _scale, _scale);
    CGContextDrawPDFPage(context, _pdfPage);
    CGContextRestoreGState(context);
}

- (void)dealloc {
//	self.layer.contents=nil;
//    self.layer.delegate=nil;
//    [self.layer removeFromSuperlayer];
	
    CGPDFPageRelease(_pdfPage);
}

@end
