//
//  ACPScrollContainer.m
//  ACPScrollMenu
//
//  Created by Antonio Casero Palmero on 8/4/13.
//  Copyright (c) 2013 ACP. All rights reserved.
//

#import "ACPScrollMenu.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ColorConversion.h"

static CGFloat const kScrollViewFirstWidth = 12.0f;
static CGFloat const kScrollViewItemMarginWidth = 5.0f;

@implementation ACPScrollMenu



# pragma mark -
# pragma mark Initialization
# pragma mark -


- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		// Do something
	}
	return self;
}

- (id)initACPScrollMenuWithFrame:(CGRect)frame withBackgroundColor:(UIColor *)bgColor menuItems:(NSArray *)menuItems {
	self = [super initWithFrame:frame];
	if (!self) {
		return nil;
	}
    
	if (menuItems.count == 0) {
		return nil;
	}
    
	[self setUpACPScrollMenu:menuItems];
	[self setACPBackgroundColor:bgColor];
    
	return self;
}

- (void)setUpACPScrollMenu:(NSArray *)menuItems {
	if (menuItems.count == 0) {
		return;
	}
	int menuItemsArrayCount = menuItems.count;
    
	// Setting ScrollView
    if(_scrollView == nil){
	_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(3, 8, 12, 30)];
    label.text = @"标签";
    label.numberOfLines = 0;
    label.textColor = [UIColor colorFromHexRGB:@"c9c9c9"];
    label.font = [UIFont systemFontOfSize:12.0];
    [_scrollView addSubview:label];
	ACPItem *menuItem = menuItems[0];
//    menuItem.backgroundColor = [UIColor colorFromHexRGB:@"80c269"];
//    menuItem.layer.borderColor = [UIColor colorFromHexRGB:@"80c269"].CGColor;
    _scrollView.contentSize = CGSizeMake(menuItem.frame.size.width * 13, 14);
	// Do not show scrollIndicator
	_scrollView.showsHorizontalScrollIndicator = NO;
	_scrollView.showsVerticalScrollIndicator = NO;
    
	_scrollView.backgroundColor = [UIColor clearColor];
	[_scrollView setUserInteractionEnabled:YES];
	[self addSubview:_scrollView];
    
	self.menuArray = menuItems;
	[self setMenu];
    
	_animationType = ACPZoomOut;
   }
}

- (void)setMenu {
	int i = 0;
	for (ACPItem *menuItem in _menuArray) {
		menuItem.tag = 1000 + i;
		menuItem.center = CGPointMake(19+menuItem.frame.size.width / 2+ kScrollViewItemMarginWidth * i + menuItem.frame.size.width * i, self.frame.size.height / 2);
        
        menuItem.layer.cornerRadius = 2.5;
        menuItem.layer.borderColor = [UIColor colorFromHexRGB:@"c9c9c9"].CGColor;
        menuItem.layer.masksToBounds = YES;
        menuItem.layer.borderWidth = 0.5;
		menuItem.delegate = self;
		[_scrollView addSubview:menuItem];
        
		i++;
	}
}


# pragma mark -
# pragma mark Delegate Methods
# pragma mark -

- (void)itemTouchesBegan:(ACPItem *)item {
	item.highlighted = YES;
}

- (void)itemTouchesEnd:(ACPItem *)item {
	// blowUp animation
    
	[self startAnimation:item];
    
    
	if ([_delegate respondsToSelector:@selector(scrollMenu:didSelectIndex:)]) {
		[_delegate scrollMenu:(id)self didSelectIndex:item.tag - 1000];
	}
}

# pragma mark -
# pragma mark Animation & behaviour
# pragma mark -

- (void)startAnimation:(ACPItem *)item {
	[self removeHighlighted];
	item.highlighted = YES;
	switch (_animationType) {
		case ACPFadeZoomIn: {
			[UIView animateWithDuration:0.25f animations: ^{
			    CGAffineTransform scaleUpAnimation = CGAffineTransformMakeScale(1.9f, 1.9f);
			    item.transform = scaleUpAnimation;
			    item.alpha = 0.2;
			} completion: ^(BOOL finished) {
			    [UIView animateWithDuration:0.25f animations: ^{
			        item.transform = CGAffineTransformIdentity;
			        item.alpha = 1.0f;
				} completion: ^(BOOL finished) {
			        item.highlighted = YES;
				}];
			}];
			break;
		}
		case ACPFadeZoomOut: {
			[UIView animateWithDuration:0.1f animations: ^{
			    CGAffineTransform scaleDownAnimation = CGAffineTransformMakeScale(0.9f, 0.9f);
			    item.transform = scaleDownAnimation;
			    item.alpha = 0.2;
			} completion: ^(BOOL finished) {
			    [UIView animateWithDuration:0.1f animations: ^{
			        item.transform = CGAffineTransformIdentity;
			        item.alpha = 1.0f;
				} completion: ^(BOOL finished) {
			        item.highlighted = YES;
				}];
			}];
			break;
		}
            
		case ACPZoomOut: {
			[UIView animateWithDuration:0.1f animations: ^{
			    CGAffineTransform scaleDownAnimation = CGAffineTransformMakeScale(0.9f, 0.9f);
			    item.transform = scaleDownAnimation;
			} completion: ^(BOOL finished) {
			    [UIView animateWithDuration:0.1f animations: ^{
			        item.transform = CGAffineTransformIdentity;
				} completion: ^(BOOL finished) {
			        item.highlighted = YES;
				}];
			}];
			break;
		}
            
		default: {
			[UIView animateWithDuration:0.25f animations: ^{
			    CGAffineTransform scaleUpAnimation = CGAffineTransformMakeScale(1.9f, 1.9f);
			    item.transform = scaleUpAnimation;
			    item.alpha = 0.2;
			} completion: ^(BOOL finished) {
			    [UIView animateWithDuration:0.25f animations: ^{
			        item.transform = CGAffineTransformIdentity;
			        item.alpha = 1.0f;
				} completion: ^(BOOL finished) {
			        item.highlighted = YES;
				}];
			}];
			break;
		}
	}
}

- (void)removeHighlighted  {
	for (ACPItem *menuItem in self.menuArray) {
		menuItem.highlighted = NO;
	}
}

- (void)setThisItemHighlighted:(NSInteger)itemNumber {
	[self removeHighlighted];
	[[self.menuArray objectAtIndex:itemNumber] setHighlighted:YES];
}

# pragma mark -
# pragma mark Extra configuration
# pragma mark -


- (void)setACPBackgroundColor:(UIColor *)color {
	self.backgroundColor = color;
}

@end
