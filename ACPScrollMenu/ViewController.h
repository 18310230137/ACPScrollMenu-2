//
//  ViewController.h
//  ACPScrollMenu
//
//  Created by BQHZ on 16/10/14.
//  Copyright © 2016年 BQHZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACPScrollMenu.h"

@interface ViewController : UIViewController<ACPScrollDelegate>

@property (nonatomic, strong) UIView *labelView;  //标签View
//标签
@property (nonatomic, strong) ACPScrollMenu *ACPScrollMenu;

@property (nonatomic, assign) NSInteger postsId; //帖子标签


@end

