#import "GTSDimention.h"
#import "NSDictionary+LoadValues.h"


@implementation GTSDimention

@synthesize startValue = _startValue;
@synthesize step = _step;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _startValue = [dictionary integerWithKey:@"start"];
        _step = [dictionary integerWithKey:@"step"];
    }
    return self;
}

+ (GTSDimention *)dimentionFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key {
    NSDictionary *data = [dictionary objectForKey:key];
    if (!data) {
        return nil;
    }

    return [[GTSDimention alloc] initWithDictionary:data];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ [startValue: %d, step: %d]",
                    [self class],
                    self.startValue,
                    self.step];
}
@end