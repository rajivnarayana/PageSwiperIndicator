//
//  WAScrollViewController.h
//  PageSwiperIndicator
//
//  Created by xcode4 on 05/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPager.h"

@interface WAScrollViewController : UIViewController<UIViewPagerDelegate> {
    UIScrollView *scrollView;
}

@end
