/* 
 * Copyright (c) 2009 Keith Lazuka
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <UIKit/UIKit.h>

@class KalTileView;
@class KalColorSource;

@interface KalMonthView : UIView {
    NSUInteger numWeeks;
    NSDateFormatter *tileAccessibilityFormatter;
    KalColorSource *colorSource;
}

@property(nonatomic) NSUInteger numWeeks;

- (id)initWithFrame:(CGRect)rect colorSource:(KalColorSource *)source;
- (void)showDates:(NSArray *)mainDates leadingAdjacentDates:(NSArray *)leadingAdjacentDates trailingAdjacentDates:(NSArray *)trailingAdjacentDates minAvailableDate:(NSDate *)minAvailableDate maxAvailableDate:(NSDate *)maxAvailableDate;

- (KalTileView *)firstTileOfMonth;

- (KalTileView *)tileForDate:(NSDate *)date;

- (void)markTilesForDates:(NSArray *)dates;

@end
