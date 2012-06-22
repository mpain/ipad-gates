#import "GTSPdfViewContainer.h"
#import "GTSPdfView.h"

@implementation GTSPdfViewContainer {
	__strong GTSPdfView *_page;
	CGPDFDocumentRef _document;
	CGPDFPageRef _rawPage;
}

@synthesize pageNumber = _pageNumber;

- (void)dealloc {
	[self releaseRawPage];
	[self releaseDocument];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		_page = [[GTSPdfView alloc] initWithFrame:self.bounds];
		_page.backgroundColor = [UIColor clearColor];
		[self addSubview:_page];
	}
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_page layoutSubviews];
}

- (void)releaseDocument {
	if (_document) {
		CGPDFDocumentRelease(_document);
		_document = nil;
	}
}

- (void)releaseRawPage {
	if (_rawPage) {
		CGPDFPageRelease(_rawPage);
		_rawPage = nil;
	}
}

- (void)setDocument:(CGPDFDocumentRef)document {
	[self releaseDocument];
	if (document) {
		_document = CGPDFDocumentRetain(document);
	}
}

- (void)setRawPage:(CGPDFPageRef)rawPage {
	[self releaseRawPage];
	if (rawPage) {
		_rawPage = CGPDFPageRetain(rawPage);
	}
}

- (void)pdfDocument:(CGPDFDocumentRef)document loadPageWithNumber:(NSInteger)pageNumber {
	if (_document) {
		return;
	}
	
	self.document = document;
	_pageNumber = pageNumber;
	[self performSelectorInBackground:@selector(loadPageAsync:) withObject:nil];
}

- (void)loadPageAsync:(id)object {
	self.rawPage = CGPDFDocumentGetPage(_document, _pageNumber);
	[self performSelectorOnMainThread:@selector(updatePageAsync:) withObject:nil waitUntilDone:NO];
}

- (void)updatePageAsync:(id)object {
	if (_rawPage) {
		[_page setPage:_rawPage];
		
		[_page layoutSubviews];
		[_page setNeedsDisplay];
		
		[self releaseRawPage];
	}
	[self releaseDocument];
}
@end
