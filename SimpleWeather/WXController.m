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

  // Set the header of your table to be the same size of your screen.
  // You’ll be taking advantage of UITableView’s paging which will page
  // the header and the daily and hourly forecast sections.
  CGRect headerFrame = [UIScreen mainScreen].bounds;

  // Create an inset (or padding) variable so that all your labels are
  // evenly spaced and centered
  CGFloat inset = 20;

  // Create and initialize the height variables for your various views.
  // Setting these values as constants makes it easy to configure and
  // changing your view setup if required.
  CGFloat temperatureHeight = 110;
  CGFloat hiloHeight = 40;
  CGFloat iconHeight = 30;

  // Create frames for your labels and icon view based on the constant
  // and inset variables.
  CGRect hiloFrame = CGRectMake(inset,
                                headerFrame.size.height - hiloHeight,
                                headerFrame.size.width - (2 * inset),
                                hiloHeight);
  CGRect temperatureFrame = CGRectMake(inset,
                                       headerFrame.size.height - (temperatureHeight + hiloHeight),
                                       headerFrame.size.width - (2 * inset),
                                       temperatureHeight);
  CGRect iconFrame = CGRectMake(inset,
                                temperatureFrame.origin.y - iconHeight,
                                iconHeight,
                                iconHeight);

  // Copy the icon frame, adjust it so the text has some room to expand,
  // and move it to the right of the icon. You’ll see how this layout
  // math works once we add the label to the view below.
  CGRect conditionsFrame = iconFrame;
  conditionsFrame.size.width = self.view.bounds.size.width - (((2 * inset) + iconHeight) + 10);
  conditionsFrame.origin.x = iconFrame.origin.x + (iconHeight + 10);

  // Set the current-conditions view as your table header.
  UIView *header = [[UIView alloc] initWithFrame:headerFrame];
  header.backgroundColor = [UIColor clearColor];
  self.tableView.tableHeaderView = header;
  
  // Build each required label to display weather data.
  // bottom left. Big one.
  UILabel *temperatureLabel = [[UILabel alloc] initWithFrame:temperatureFrame];
  temperatureLabel.backgroundColor = [UIColor clearColor];
  temperatureLabel.textColor = [UIColor whiteColor];
  temperatureLabel.text = @"0°";
  temperatureLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120];
  [header addSubview:temperatureLabel];
  
  // bottom left. Small one under tempperatureLabel
  UILabel *hiloLabel = [[UILabel alloc] initWithFrame:hiloFrame];
  hiloLabel.backgroundColor = [UIColor clearColor];
  hiloLabel.textColor = [UIColor whiteColor];
  hiloLabel.text = @"0° / 0°";
  hiloLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];
  [header addSubview:hiloLabel];
  
  // top
  UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 30)];
  cityLabel.backgroundColor = [UIColor clearColor];
  cityLabel.textColor = [UIColor whiteColor];
  cityLabel.text = @"Loading...";
  cityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
  cityLabel.textAlignment = NSTextAlignmentCenter;
  [header addSubview:cityLabel];
  
  // bottom left. Next to iconView
  UILabel *conditionsLabel = [[UILabel alloc] initWithFrame:conditionsFrame];
  conditionsLabel.backgroundColor = [UIColor clearColor];
  conditionsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
  conditionsLabel.textColor = [UIColor whiteColor];
  [header addSubview:conditionsLabel];
  
  // Add an image view for a weather icon.
  // bottom left. On the top of temperatureLabel
  UIImageView *iconView = [[UIImageView alloc] initWithFrame:iconFrame];
  iconView.contentMode = UIViewContentModeScaleAspectFit;
  iconView.backgroundColor = [UIColor clearColor];
  [header addSubview:iconView];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGRect bounds = self.view.bounds;

  self.backgroundImageView.frame = bounds;
  self.blurredImageView.frame = bounds;
  self.tableView.frame = bounds;
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

  // Forecast cells shouldn’t be selectable. Give them a semi-transparent
  // black background and white text.
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
  cell.textLabel.textColor = [UIColor whiteColor];
  cell.detailTextLabel.textColor = [UIColor whiteColor];

  // TODO: Setup the cell

  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  // TODO: Determine cell height based on screen
  return 44;
}

@end
