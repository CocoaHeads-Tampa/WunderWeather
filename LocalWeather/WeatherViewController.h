//
//  ViewController.h
//  LocalWeather
//
//  Created by Chris Woodard on 7/4/13.
//  Copyright (c) 2013 Chris Woodard.. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CurrentWeatherView.h"

@interface WeatherViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *cityStateCountryLabel;
@property (nonatomic, weak) IBOutlet CurrentWeatherView *currentWeatherView;
@property (nonatomic, weak) IBOutlet UITableView *forecastTable;

-(IBAction)refresh:(id)sender;

@end
