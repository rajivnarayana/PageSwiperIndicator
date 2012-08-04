//
//  UIViewPager.h
//  PageSwiperIndicator
//
//  Created by xcode4 on 03/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIViewPagerDelegate <NSObject>

@required
- (void) switchToPageIndex:(int) page;
- (NSString *) titleForLabelForPage:(int)page;

@optional
- (UIView *) tilteViewForPage:(int) page;

@end


@interface UIViewPager : UIView<UIScrollViewDelegate> {
    UILabel *firstLabel;
    CGFloat firstLabelWidth;
    UILabel *secondLabel;
    CGFloat secondLabelWidth;
    UILabel *thirdLabel;
    __unsafe_unretained id<UIViewPagerDelegate> delegate;
    CGFloat horizontalOffset;
}

@property(nonatomic, unsafe_unretained) id<UIViewPagerDelegate> delegate;

@end
