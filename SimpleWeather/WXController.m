//
//  WXController.m
//  SimpleWeather
//
//  Created by Masayoshi Sekimura on 12/21/14.
//  Copyright (c) 2014 Magic Symmetry. All rights reserved.
//

#import "WXController.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>

@interface WXController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blurredImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat screenHeight;
@end

@implementation WXController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Get and store the screen height. You’ll need this later when displaying
    // all of the weather data in a paged manner.
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;

    // Create a static image background and add it to the view.
    UIImage *background = [UIImage imageNamed:@"bg"];
    self.backgroundImageView = [[UIImageView alloc] initWithImage:background];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];

    // Create a blurred background image using LBBlurredImage, and set the
    // alpha to 0 initially so that backgroundImageView is visible at first.
    self.blurredImageView = [[UIImageView alloc] init];
    self.blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.blurredImageView.alpha = 0;
    [self.blurredImageView setImageToBlur:background blurRadius:10 completionBlock:nil];
    [self.view addSubview:self.blurredImageView];

    // Create a tableview that will handle all the data presentation.
    // WXController will be the delegate and data source, as well as the
    // scroll view delegate. Note that you’re also setting pagingEnabled to
    // YES.
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // TODO: Return count of forecast
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellId = @"CellId";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

  if (! cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
  }

  // TODO: Tweak cell stile a bit
  // TODO: Setup the cell

  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  // TODO: Determine cell height based on screen
  return 44;
}

@end
