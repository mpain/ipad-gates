#import "GTSBooleanCell.h"
#import "GTSBooleanElement.h"

@implementation GTSBooleanCell

@synthesize switchOn = _switchOn;

- (GTSBooleanElement *)booleanElement {
    return (GTSBooleanElement *)self.element;
}

- (void)updateCellFromElement {
    self.switchOn.on = self.booleanElement.isOn;
    [super updateCellFromElement];
}

- (IBAction)didSwitchValueChange {
    self.booleanElement.on = self.switchOn.isOn;
    [self notificateAboutValueWasChanged];
}

@end
