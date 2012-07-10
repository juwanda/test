//
//  UIView+Layout.h
//
//  Created by Locassa on 06/07/2010.
//  Copyright Locassa Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Layout)

- (double)width;
- (void)setWidth:(double)width;

- (double) height;
- (void) setHeight:(double)height;

- (CGSize) size;
- (void) setSize:(CGSize)size;

- (CGPoint) origin;
- (double) xPosition;
- (double) yPosition;
- (double) baselinePosition;

- (void) positionAtX:(double)xValue;
- (void) positionAtY:(double)yValue;
- (void) positionAtX:(double)xValue andY:(double)yValue;

- (void) positionAtX:(double)xValue andY:(double)yValue withWidth:(double)width;
- (void) positionAtX:(double)xValue andY:(double)yValue withHeight:(double)height;

- (void) positionAtX:(double)xValue withHeight:(double)height;

- (void) removeSubviews;

- (void) centerInSuperView;
- (void) astheticCenterInSuperView;

- (void) bringToFront;
- (void) sendToBack;

@end
