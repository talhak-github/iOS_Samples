//
//  SNRCustomAgendaViewCell.h
//  Sunrise
//
//  Created by Talha Khalid
//

#import <UIKit/UIKit.h>

@interface SNRCustomAgendaViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *eventName;
@property (nonatomic, strong) IBOutlet UILabel *eventTime;
@property (nonatomic, strong) IBOutlet UILabel *eventDuration;
@property (nonatomic, strong) IBOutlet UILabel *eventLocation;
@property (nonatomic, strong) IBOutlet UIImageView *eventIcon;

@end
