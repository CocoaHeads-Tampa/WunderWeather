//
//  CurrentWeatherView.h
//  LocalWeather
//
//  Created by Chris Woodard on 7/11/13.
//  Copyright (c) 2013 Chris Woodard.. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CurrentWeather.h"

@interface CurrentWeatherView : UIView

@property (nonatomic, weak) IBOutlet UIWebView *webView;

-(void)setValuesInHTMLFromModel:(CurrentWeather *)currentWeather;
-(void)loadHTML;

@end
