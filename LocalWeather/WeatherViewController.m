//
//  ViewController.m
//  LocalWeather
//
//  Created by Chris Woodard on 7/4/13.
//  Copyright (c) 2013 Chris Woodard.. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherFetcher.h"
#import "SVProgressHUD.h"
#import "ForecastTableCell.h"

@interface WeatherViewController () 

@property (nonatomic, strong) WeatherForecast *forecast;

@end

@implementation WeatherViewController

-(IBAction)refresh:(id)sender
{
    WeatherFetcher *fetcher = [WeatherFetcher defaultFetcher];

    [SVProgressHUD showWithStatus:@"Fetching Current Weather"];
    [fetcher fetchCurrentLocalWeatherWithCompletion:^(NSHTTPURLResponse *response, NSError *err){
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(nil == err)
            {
                CurrentWeather *cw = [fetcher currentWeather];
                [_currentWeatherView setValuesInHTMLFromModel:cw];
            }
            [SVProgressHUD dismiss];
        });
    }];

    [SVProgressHUD showWithStatus:@"Fetching Weather Forecast"];
    [fetcher fetch3DayLocalForecastWithCompletion:^(NSHTTPURLResponse *response, NSError *err){
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(nil == err)
            {
            _forecast = [fetcher lastForecast];
            [_forecastTable reloadData];
            }
            [SVProgressHUD dismiss];
        });
    }];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [_currentWeatherView loadHTML];
    [self refresh:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - WebView

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL shouldReturn = YES;
    NSString *uri = [[request URL] lastPathComponent];
    if([@"RELOAD" isEqualToString:uri])
    {
        shouldReturn = NO;
        [self refresh:nil];
    }
    return shouldReturn;
}

#pragma mark - UITableView data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numDaysInForecast = 0;
    if(nil != _forecast)
        numDaysInForecast =[_forecast numberOfDaysInForecast];
    return numDaysInForecast;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ForecastTableCell preferredHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForecastTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastTableCell"];
    if(nil == cell)
        cell = (ForecastTableCell *)[[ForecastTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ForecastTableCell"];
    [cell setLabelsFromData:[_forecast forecastAtIndex:indexPath.row]];
    return cell;
}

@end
