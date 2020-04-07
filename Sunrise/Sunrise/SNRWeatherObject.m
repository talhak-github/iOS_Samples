//
//  SNRWeatherObject.m
//  Sunrise
//
//  Created by Talha on 2015-07-07.
//  Copyright (c) 2015 Talha. All rights reserved.
//

#import "SNRWeatherObject.h"

@implementation SNRWeatherObject

-(instancetype)initWithHighTempForecast:(NSString*)highTempForecast lowTempForecast: (NSString*)lowTempForecast
{
    self = [super init];
    
    if (self)
    {
        self.highTempForecast = highTempForecast;
        self.lowTempForecast = lowTempForecast;
    }
    
    return self;
}

@end
