//
//  ViewController.m
//  ACPScrollMenu
//
//  Created by BQHZ on 16/10/14.
//  Copyright © 2016年 BQHZ. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+ColorConversion.h"
#import "ACPItem.h"
#import "ACPScrollMenu.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor cyanColor];
    [self labelCategory];
    
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [self labelCategory];
//}
//添加标签的view
- (void)labelCategory
{
    _labelView = [[UIView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height/2), [UIScreen mainScreen].bounds.size.width, 49)];
    _labelView.backgroundColor = [UIColor colorFromHexRGB:@"f9f9f9"];
//    [[[[UIApplication sharedApplication] delegate] window]addSubview:_labelView];
    [self.view addSubview:_labelView];
    [self setUpACPScrollMenu];
    
}

//设置滚动标签
- (void)setUpACPScrollMenu
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *titleArr = [[NSMutableArray alloc] initWithObjects:@"吐槽",@"晒照",@"交友", @"萌宝",@"宠物", @"美女",@"拼车",@"活动", @"二手",@"其它", nil];
    for (int i = 0; i < 10; i ++) {
        ACPItem *item = [[ACPItem alloc] initACPItem:nil iconImage:nil andLabel:[titleArr objectAtIndex:i]];
        [item setHighlightedBackground:nil iconHighlighted:nil textColorHighlighted:[UIColor colorFromHexRGB:@"f57a19"]];
        [array addObject:item];
    }
    _ACPScrollMenu = [[ACPScrollMenu alloc] initACPScrollMenuWithFrame:CGRectMake(0, 3, [UIScreen mainScreen].bounds.size.width, 44) withBackgroundColor:nil menuItems:array];
    [_ACPScrollMenu setUpACPScrollMenu:array];
    [_ACPScrollMenu setAnimationType:ACPZoomOut];
    _ACPScrollMenu.delegate = self;
    [_labelView addSubview:_ACPScrollMenu];
    
    
}

- (void)scrollMenu:(ACPItem *)menu didSelectIndex:(NSInteger)selectedIndex {
    
    _postsId = selectedIndex + 1;
//    DBLog(@"-----postsId=%ld", (long)_postsId);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
