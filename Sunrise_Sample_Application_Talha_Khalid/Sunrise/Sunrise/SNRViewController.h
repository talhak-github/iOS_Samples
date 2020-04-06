//
//  ViewController.h
//  
//
//  Created by Talha on 2015-06-24.
//  Copyright (c) 2015 Talha. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    This UIViewController adopts the following protocols:
 
    UICollectionView protocols
        UICollectionViewDataSource
        UICollectionViewDelegate
        UICollectionViewDelegateFlowLayout
 */
@interface SNRViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *agendaView;
@property (nonatomic, strong) NSMutableDictionary *events;
@property (nonatomic, strong) IBOutlet UICollectionView *calendarView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarViewHeight;


@end