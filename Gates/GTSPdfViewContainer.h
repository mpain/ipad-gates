#import <UIKit/UIKit.h>

@interface GTSPdfViewContainer : UIView

@property (nonatomic, assign, readonly) NSInteger pageNumber;

- (void)pdfDocument:(CGPDFDocumentRef)document loadPageWithNumber:(NSInteger)pageNumber;

@end
