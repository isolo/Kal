/*
 * Copyright (c) 2009 Keith Lazuka
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "KalTileView.h"
#import "KalColorSource.h"

extern const CGSize kTileSize;

@implementation KalTileView

- (id)initWithFrame:(CGRect)frame colorSource:(KalColorSource *)source {
    colorSource = source;
    if ((self = [super initWithFrame:frame])) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        origin = frame.origin;
        [self setIsAccessibilityElement:YES];
        [self setAccessibilityTraits:UIAccessibilityTraitButton];
        [self resetState];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat fontSize = 15;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
    UIColor *textColor = colorSource.normalColor;
    CGContextSelectFont(ctx, [font.fontName cStringUsingEncoding:NSUTF8StringEncoding], fontSize, kCGEncodingMacRoman);

    if (self.isDisable) {
        textColor = colorSource.inactiveColor;
    } else if (self.belongsToAdjacentMonth) {
       [[UIColor clearColor] setFill];
        CGContextFillRect(ctx, CGRectMake(0.f, 1.f, kTileSize.width, kTileSize.height));
        textColor = colorSource.inactiveColor;
    } else {
        textColor = colorSource.normalColor;
    }
    if (self.isMarked) {
        UIImage *markerImage = [UIImage imageNamed:@"Kal.bundle/kal_marker.png"];
        [markerImage drawInRect:CGRectMake(21.f, 5.f, 4.f, 5.f)];
    }

    if (self.isToday) {
        UIImage *image = [UIImage imageNamed:@"Kal.bundle/kal_tile_today.png"];
        CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
        frame.origin.y = (kTileSize.height - frame.size.height) / 2;
        [image drawInRect:frame];
    }

    if (self.state == KalTileStateHighlighted || self.state == KalTileStateSelected) {
        UIImage *image = [UIImage imageNamed:@"Kal.bundle/kal_tile_selected.png"];
        CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
        frame.origin.x = (kTileSize.width - frame.size.width) / 2;
        frame.origin.y = (kTileSize.height - frame.size.height) / 2;
        [image drawInRect:frame];
        textColor = colorSource.selectedColor;
    } else if (self.state == KalTileStateLeftEnd) {
        UIImage *image = [UIImage imageNamed:@"Kal.bundle/kal_tile_range_left.png"];
        CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
        frame.origin.x = (kTileSize.width - frame.size.width) / 2;
        frame.origin.y = (kTileSize.height - frame.size.height) / 2;
        [image drawInRect:frame];
        textColor = colorSource.selectedColor;
    } else if (self.state == KalTileStateRightEnd) {
        UIImage *image = [UIImage imageNamed:@"Kal.bundle/kal_tile_range_right.png"];
        CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
        frame.origin.x = (kTileSize.width - frame.size.width) / 2;
        frame.origin.y = (kTileSize.height - frame.size.height) / 2;
        [image drawInRect:frame];
        textColor = colorSource.selectedColor;
    } else if (self.state == KalTileStateInRange) {
        UIImage *image = [UIImage imageNamed:@"Kal.bundle/kal_tile_range.png"];
        CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
        frame.origin.y = (kTileSize.height - frame.size.height) / 2;
        textColor = colorSource.selectedColor;
        [image drawInRect:frame];
    }

    NSUInteger n = [self.date day];
    NSString *dayText = [NSString stringWithFormat:@"%lu", (unsigned long) n];
    CGSize textSize = [dayText sizeWithFont:font];
    CGFloat textX, textY;
    textX = roundf(0.5f * (kTileSize.width - textSize.width));
    textY = roundf(0.5f * (kTileSize.height - textSize.height));
    [textColor setFill];
    [dayText drawAtPoint:CGPointMake(textX, textY) withFont:font];
}

- (void)resetState {
    // realign to the grid
    CGRect frame = self.frame;
    frame.origin = origin;
    frame.size = kTileSize;
    self.frame = frame;

    self.date = nil;
    _type = KalTileTypeRegular;
    self.state = KalTileStateNone;
}

- (void)setDate:(NSDate *)aDate {
    if (_date == aDate)
        return;

    _date = aDate;

    [self setNeedsDisplay];
}

- (void)setState:(KalTileState)state {
    if (_state != state) {
        _state = state;
        [self setNeedsDisplay];
    }
}

- (void)setType:(KalTileType)tileType {
    if (_type != tileType) {
        _type = tileType;
        [self setNeedsDisplay];
    }
}

- (BOOL)isToday {
    return self.type & KalTileTypeToday;
}

- (BOOL)isFirst {
    return self.type & KalTileTypeFirst;
}

- (BOOL)isLast {
    return self.type & KalTileTypeLast;
}

- (BOOL)isDisable {
    return self.type & KalTileTypeDisable;
}

- (BOOL)isMarked {
    return self.type & KalTileTypeMarked;
}

- (BOOL)belongsToAdjacentMonth {
    return self.type & KalTileTypeAdjacent;
}

@end
