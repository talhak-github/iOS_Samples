//
//  SNRWeatherObject.h
//  Sunrise
//
//  Created by Talha on 2015-07-07.
//  Copyright (c) 2015 Talha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNRWeatherObject : NSObject

-(instancetype)initWithHighTempForecast:(NSString*)highTempForecast lowTempForecast: (NSString*)lowTempForecast;

@property (nonatomic, strong) NSString *highTempForecast;
@property (nonatomic, strong) NSString *lowTempForecast;

@end
