//
//  SNREvent.h
//  Sunrise
//  Created by Talha Khalid
//

#import <Foundation/Foundation.h>

@interface SNREvent : NSObject

@property (nonatomic, strong) NSString *eventName;
@property (nonatomic) NSDate *eventDate;
@property (nonatomic, strong) NSString *eventTime;
@property (nonatomic) NSString *eventDuration;
@property (nonatomic) NSString *eventDurationString;
@property (nonatomic, strong) NSString *eventLocation;
@property (nonatomic, strong) NSString *eventIcon;

- (instancetype)initWithEventName:(NSString*)name
                             date:(NSDate*)date
                             time:(NSString*)time
                         duration:(NSString*)duration
                         location:(NSString*)location
                             icon:(NSString*)icon;

- (instancetype)initWithEventName:(NSString*)name
                             date:(NSDate*)date
                         duration:(NSString*)duration
                         location:(NSString*)location
                             icon:(NSString*)icon;

@end