//
//  HLTCheckListItem.h
//  HealthTap
//
//  Created by Talha Khalid on 1/3/2016.
//  Copyright (c) 2016 Talha Khalid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLTCheckListItem : NSObject

@property (nonatomic, strong) NSString* text;
@property int frequency;
@property BOOL completed;

@end
