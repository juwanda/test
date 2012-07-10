//
//  LORichTextLabel.m
//  RichTextLabel
//
//  Created by Locassa on 19/06/2011.
//  Copyright 2011 Locassa Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LORichTextLabelStyle.h"


@interface LORichTextLabel : UIView {
	NSMutableDictionary *highlightStyles;
	NSArray *elements;
	UIColor *textColor;
	UIFont *font;    
    NSString *text;
}
@property (nonatomic, readonly) UIFont *font;
@property (nonatomic, readonly) NSString *text;
- (id)initWithWidth:(CGFloat)aWidth;
- (void)addStyle:(LORichTextLabelStyle *)aStyle forPrefix:(NSString *)aPrefix;
- (void)setFont:(UIFont *)value;
- (void)setTextColor:(UIColor *)value;
- (void)setText:(NSString *)value;

@end
