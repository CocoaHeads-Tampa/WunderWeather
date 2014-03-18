//
//  CurrentWeatherView.m
//  LocalWeather
//
//  Created by Chris Woodard on 7/11/13.
//  Copyright (c) 2013 Chris Woodard.. All rights reserved.
//

#import "CurrentWeatherView.h"
#import "CurrentWeather.h"
#import "WeatherForecast.h"
#import "WeatherFetcher.h"

@implementation CurrentWeatherView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

-(void)loadHTML
{
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"weather" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:html baseURL:nil];
}

-(void)setValuesInHTMLFromModel:(CurrentWeather *)currentWeather
{
    NSString *json = [currentWeather toJSON];
    NSString *javascriptCall = [NSString stringWithFormat:@"setInitialValues(%@)", json];
    [_webView stringByEvaluatingJavaScriptFromString:javascriptCall];
}

@end
