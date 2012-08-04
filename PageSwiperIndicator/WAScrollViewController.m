//
//  WAScrollViewController.m
//  PageSwiperIndicator
//
//  Created by xcode4 on 05/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WAScrollViewController.h"

@implementation WAScrollViewController

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];//will initialize self.view.
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 50)];
    [self.view addSubview:scrollView];
    
    //Add two pages to the scroll view.
    UIView *firstView = [[UIView alloc] initWithFrame:scrollView.bounds];
    firstView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:firstView];
    
    //Add second page.
    UIView *secondView = [[UIView alloc] initWithFrame:scrollView.bounds];
    secondView.backgroundColor = [UIColor blueColor];
    [scrollView addSubview:secondView];
    secondView.frame = CGRectOffset(secondView.frame, scrollView.bounds.size.width, 0);
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 2, scrollView.frame.size.height);
    
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //Add view pager.
    UIViewPager *viewPager = [[UIViewPager alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    [self.view addSubview:viewPager];
    viewPager.delegate = self;
    scrollView.delegate = viewPager;
}

#pragma mark UIViewPagerDelegate protocol implementation.

- (NSString *) titleForLabelForPage:(int)page {
    if (page == 0) {
        return @"All";
    }
    if (page == 1) {
        return @"Tips";
    }
    return nil;
}

- (void) switchToPageIndex:(int)page {
    [scrollView setContentOffset:CGPointMake(page * scrollView.bounds.size.width,0) animated:YES];
}

@end
