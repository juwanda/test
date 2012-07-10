//
//  LORichTextLabel.m
//  RichTextLabel
//
//  Created by Locassa on 19/06/2011.
//  Copyright 2011 Locassa Ltd. All rights reserved.
//

#import "LORichTextLabel.h"
#import "UIView+Layout.h"


@implementation LORichTextLabel
@synthesize font = font;
@synthesize text = text;

- (id)initWithWidth:(CGFloat)aWidth {
	self = [super initWithFrame:CGRectMake(0.0, 0.0, aWidth, 0.0)];
	
	if(self != nil) {
		highlightStyles = [[NSMutableDictionary alloc] init];
		elements = [[NSMutableArray alloc] init];		

		font = [UIFont fontWithName:@"Helvetica" size:12.0];
		[font retain];
		
		textColor = [UIColor blackColor];
		[textColor retain];
	}
	
	return self;
}

- (void)dealloc {
	[highlightStyles release];
	[elements release];
	[font release];
	[textColor release];
	[text release];
	[super dealloc];
}

#pragma mark -
#pragma mark Mutators

- (void)addStyle:(LORichTextLabelStyle *)aStyle forPrefix:(NSString *)aPrefix {	
	if((aPrefix == nil) || (aPrefix.length == 0)) {
		[NSException raise:NSInternalInconsistencyException 
				format:@"Prefix must be specified in %@", NSStringFromSelector(_cmd)];
	}
	
	[highlightStyles setObject:aStyle forKey:aPrefix];
}

- (void)setFont:(UIFont *)value {
	if([font isEqual:value]) {
		return;
	}
	
	[font release];
	font = value;
	[font retain];
	
	[self setNeedsDisplay];	
}

- (void)setTextColor:(UIColor *)value {
	if([textColor isEqual:value]) {
		return;
	}
	
	[textColor release];
	textColor = value;
	[textColor retain];
	
	[self setNeedsLayout];
}

- (void)setText:(NSString *)value {
    [text release];
    text = [value copy];
	[elements release];
	elements = [value componentsSeparatedByString:@" "];
	[elements retain];

	[self setNeedsLayout];
}

#pragma mark -
#pragma mark Drawing Methods

- (void)layoutSubviews {
	[self removeSubviews];
	
	NSUInteger maxHeight = 999999;
	CGPoint position = CGPointZero;
	CGSize measureSize = CGSizeMake(self.size.width, maxHeight);
	
	for(NSString *element in elements) {
        
		LORichTextLabelStyle *style = nil;
        NSString *curPrefix = nil;
		
		// Find suitable style
		for(NSString *prefix in [highlightStyles allKeys]) {
			if([element hasPrefix:prefix]) {
                curPrefix = prefix;
				style = [highlightStyles objectForKey:prefix];
				break;
			}
		}
        
        if (style.removePrefix && curPrefix) {
            element = [element stringByReplacingOccurrencesOfString:curPrefix withString:@""];                
        }
			
		UIFont *styleFont = style.font == nil ? font : style.font;
		UIColor *styleColor = style.color == nil ? textColor : style.color;
		
		// Get size of content (check current line before starting new one)
		CGSize remainingSize = CGSizeMake(measureSize.width - position.x, maxHeight);
		CGSize singleLineSize = CGSizeMake(remainingSize.width, 0.0);
		
		CGSize controlSize = [element sizeWithFont:styleFont constrainedToSize:singleLineSize lineBreakMode:UILineBreakModeTailTruncation];
		CGSize elementSize = [element sizeWithFont:styleFont constrainedToSize:remainingSize]; 		        

		if(elementSize.height > controlSize.height || singleLineSize.width < 0) {
            CGSize stdSize = [element sizeWithFont:styleFont];
			position.y += stdSize.height;
			position.x = 0.0;
		}
        
        /*
        NSLog(@"element: %@ x: %f y: %f controlSize: %f elementSize: %f lineSize: %f", element, position.x, position.y, controlSize.height, elementSize.height, singleLineSize.width);*/

		elementSize = [element sizeWithFont:styleFont constrainedToSize:measureSize];
		CGRect elementFrame = CGRectMake(position.x, position.y, elementSize.width, elementSize.height);		        
        
		// Add button or label depending on whether we have a target
		if(style.target != nil) {
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
			[button addTarget:style.target action:style.action forControlEvents:UIControlEventTouchUpInside];
			[button setTitle:element forState:UIControlStateNormal];
			[button setTitleColor:styleColor forState:UIControlStateNormal];
			[button setFrame:elementFrame];
			[button.titleLabel setFont:styleFont];
			[self addSubview:button];			
		} else {
			UILabel *label = [[UILabel alloc] initWithFrame:elementFrame];
			[label setBackgroundColor:[UIColor clearColor]];
			[label setNumberOfLines:maxHeight];
			[label setFont:styleFont];
			[label setTextColor:styleColor];                        
            
			[label setText:element];
			[self addSubview:label];
		}
		
		CGSize spaceSize = [@" " sizeWithFont:styleFont];
		position.x += elementSize.width + spaceSize.width;
		
		if([element isEqual:[elements lastObject]]) {
			position.y += controlSize.height;	
		}
	}
	
	[self setSize:CGSizeMake(self.size.width, position.y)];
}

@end
