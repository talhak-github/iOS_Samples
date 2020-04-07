//
//  SNREvent.m
//  Sunrise
//  Created by Talha Khalid
//

#import "SNREvent.h"

@implementation SNREvent

- (instancetype)initWithEventName:(NSString*)name
                             date:(NSDate*)date
                             time:(NSString*)time
                         duration:(NSString*)duration
                         location:(NSString*)location
                             icon:(NSString*)icon
{
    
    //call the superclass's designated initializer
    self = [super init];
    
    //did the superclass's designated initializer succeed?
    if (self){
        //give the instance variables initial values
        _eventName = name;
        _eventDate = date;
        _eventTime = time;
        _eventDuration = duration;
        _eventLocation = location;
        _eventIcon = icon;
    }
    
    //return the address of the newly initialized object
    return self;
}

- (instancetype)initWithEventName:(NSString*)name
                             date:(NSDate*)date
                         duration:(NSString*)duration
                         location:(NSString*)location
                             icon:(NSString*)icon
{
    //call the superclass's designated initializer
    self = [super init];
    
    //did the superclass's designated initializer succeed?
    if (self){
        //give the instance variables initial values
        self.eventName = name;
        self.eventDate = date;
        self.eventDurationString = duration;
        self.eventLocation = location;
        self.eventIcon = icon;
    }
    
    //return the address of the newly initialized object
    return self;
}

@end