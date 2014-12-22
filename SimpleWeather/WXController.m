//
//  WXController.m
//  SimpleWeather
//
//  Created by Masayoshi Sekimura on 12/21/14.
//  Copyright (c) 2014 Magic Symmetry. All rights reserved.
//

#import "WXController.h"

@interface WXController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blurredImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat screenHeight;
@end

@implementation WXController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Remove this later
    self.view.backgroundColor = [UIColor redColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
