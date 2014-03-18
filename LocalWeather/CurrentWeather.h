//
//  CurrentWeather.h
//  LocalWeather
//
//  Created by Chris Woodard on 7/14/13.
//  Copyright (c) 2013 Chris Woodard.. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TempScaleCelsius = 0,
    TempScaleFahrenheit = 1
} WeatherTempScale;

@interface CurrentWeather : NSObject

-(float)currentTempForScale:(WeatherTempScale)scale;
-(float)feelsLikeTempForScale:(WeatherTempScale)scale;
-(NSString *)relativeHumidity;
-(float)cloudiness;
-(NSString *)weatherDescription;
-(float)windSpeed;
-(float)windGust;
-(NSString *)windSpeedString;
-(float)windHeading;
-(NSString *)windHeadingString;
-(float)mmHG;
-(NSString *)localeName;
-(NSString *)lastUpdatedDateTime;

-(CurrentWeather *)initWithDict:(NSDictionary *)weatherDict;
-(NSString *)toJSON;

@end
