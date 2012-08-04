//
//  UIViewPager.m
//  PageSwiperIndicator
//
//  Created by xcode4 on 03/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIViewPager.h"

@implementation UIViewPager

@synthesize delegate;

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        firstLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        firstLabel.backgroundColor = [UIColor clearColor];
        firstLabel.text = @"All";
//        [firstLabel sizeToFit];
        [self addSubview:firstLabel];
        
        secondLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        secondLabel.text = @"Tips";
        secondLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:secondLabel];
//        [secondLabel sizeToFit];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void) layoutSubviews {
    CGFloat width = self.bounds.size.width;
    CGFloat firstLabelOffset = width/2 - firstLabelWidth/2;
    if (horizontalOffset > width/2) {
        firstLabelOffset = 0;
    } else {
        firstLabelOffset = width/2 - horizontalOffset - firstLabelWidth/2;
    }
    if (firstLabelOffset < 0) {
        firstLabelOffset = 0;
    }
    firstLabel.frame = CGRectMake(firstLabelOffset, 0, firstLabelWidth, self.bounds.size.height);
    
    CGFloat secondLabelOffset = width - secondLabelWidth/2;
    if (horizontalOffset < width/2) {
        secondLabelOffset = width - secondLabelWidth/2;
    } else {
        secondLabelOffset = width - (horizontalOffset - width/2) - secondLabelWidth/2;
    }
    if (secondLabelWidth + secondLabelOffset > width) {
        secondLabelOffset = width - secondLabelWidth;
    }
    secondLabel.frame = CGRectMake(secondLabelOffset, 0, secondLabelWidth, self.bounds.size.height);
}

#pragma mark UIScrollViewDelegate protocol implementation.

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"Content offset:%@",NSStringFromCGPoint(scrollView.contentOffset));
    horizontalOffset = scrollView.contentOffset.x;
    [self setNeedsLayout];
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //TODO: draw a small triangle.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat halfWidth = self.bounds.size.width / 2;
    CGFloat height = self.bounds.size.height - 3;
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, halfWidth - 8/2, height);
    CGContextAddLineToPoint(ctx, halfWidth, height - 8/2 /** sqrt(3)*/);
    CGContextAddLineToPoint(ctx, halfWidth + 8/2, height);
    CGContextClosePath(ctx);
    
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
//    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//    CGContextStrokePath(ctx);
    CGContextFillPath(ctx);
    
    CGContextFillRect(ctx, CGRectMake(0, height, self.bounds.size.width, 3));
}

- (void) tapped:(UITapGestureRecognizer *) tapGestureRecognizer {
    CGPoint locationInView = [tapGestureRecognizer locationInView:self];
    CGFloat width = self.bounds.size.width;
    if (locationInView.x < width/3) {
        if (horizontalOffset >= width / 2) {
            [delegate switchToPageIndex:0];
        }
    } else if (locationInView.x > width * 2/3) {
        if (horizontalOffset <= width/2) {
            [delegate switchToPageIndex:1];
        }
    }
}

- (void) setDelegate:(id<UIViewPagerDelegate>)delegate_ {
    delegate = delegate_;
    firstLabel.text = [delegate titleForLabelForPage:0];
    firstLabelWidth = [firstLabel sizeThatFits:self.bounds.size].width;
    
    secondLabel.text = [delegate titleForLabelForPage:1];
    secondLabelWidth = [secondLabel sizeThatFits:self.bounds.size].width;
}
@end
