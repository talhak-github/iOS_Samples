//
//  ViewController.m
//  
//
//  Created by Talha on 2015-06-24.
//  Copyright (c) 2015 Talha. All rights reserved.
//

//IMPORTANT NOTE:
//
//IN THE TOP THIRD OF THE SCREEN, WHEREBY THE LIST OF DATES IS DISPLAYED IN THE CALENDAR VIEW
//DO NOT CLICK ON A DATE OTHER THAN {Jan 1, Jan 11, Jan 12, Jan 14, Feb 25};
//OTHERWISE THE APPLICATION WILL CRASH


// README

//Sunrise Calendar iPhone Sample Application
//Created by Talha Khalid
//
//I created a very basic sample of the Sunrise iPhone application - this sample displays my ability to properly use Collection Views and Table Views.
//
//—
//
//NOTE:
//This submission is not my “best” work. It needs great improvements on many fronts:
//Code needs to be well documented
//The UI needs to be “fixed” such that the blue circle displays properly for a selected date in the Calendar View (CollectionView)
//The Calendar View (CollectionView) needs to be better presented; currently, the cells do not display in a well-aligned fashion
//The code needs to be refactored to eliminate duplicate code; likewise, duplicate code needs to be moved into its own helper function
//
//BUGS AND DEFECTS:
//Currently, the user can only select the following dates in the Calendar View (CollectionView), displayed in the top-third of the screen: Jan 1, Jan 11, Jan 12, Jan 14, Feb 25
//Clicking on any other date in the Calendar View (CollectionView) will cause the application to crash; this is a known defect and needs to be addressed by adding further functionality in the code
//
//OVERVIEW:
//Without further ado, here is an overview of the sample application!
//
//I created a very basic sample of the Sunrise iPhone application - this sample displays my ability to properly use Collection Views and Table Views.
//
//For the sample, I created a Calendar View, displayed in the top-third of the screen. This Calendar View uses a CollectionView, and is populated with all of the dates for the Calendar Year 2012, starting from Jan 1, 2012 to Dec 31, 2012.
//
//The bottom two-thirds of the application displays the Agenda View, implemented via a Table View. The Agenda View displays events on a particular date. For example, Wed. Jan 11 contains 3 events.
//
//INTERACTION BETWEEN CALENDAR VIEW AND AGENDA VIEW:
//The cool functionality in this sample application comes about in the interaction between the Calendar View (CollectionView) and the Agenda View (TableView).
//
//The user is able to click on a date in the Calendar View; the date is subsequently highlighted with a blue image. Once the user clicks on that date, the Agenda View (TableView) scrolls to that particular date.
//
//For example, clicking on Jan 11 in the Calendar View (CollectionView) will cause the Agenda View (TableView) to scroll its rows up such that Wednesday, Jan 11 is the date displayed at the top of the Agenda View; accordingly, the events for Jan 11 are displayed beneath.
//
//Likewise, in a reverse manner, when the user scrolls through the agenda view (table-view), the dates in the calendar view (collection-view) above become highlighted.
//
//Try it out!
//
//Swipe up and down on the calendar view (table view) of events, and you will notice that the date for the day at the very top of the table view becomes highlighted in the collection view (agenda view) above. It’s pretty cool - this interaction between the TableView and CollectionView.
//
//I achieved this interaction via careful usage of index paths and the corresponding delegate methods for TableView and CollectionView.
//
//EXPANDING NATURE OF THE CALENDAR VIEW (CollectionView):
//In addition, the Calendar View (CollectionView) visible in the top third of the screen can be expanded.
//
//Simply swipe down on the Calendar View (CollectionView), and you will notice that the Calendar View (CollectionView) occupies roughly more than half of the screen.
//
//You can scroll through this Calendar View from Jan 1 2012 to Dec 31, 2012 in this “expanded” mode.
//
//Be sure that you do not actually select a date in the Calendar View that is not included in the aforementioned set of dates mentioned above in this README file; otherwise, the application will crash. (These dates are Jan 1, Jan 11, Jan 12, Jan 14, Feb 25).
//
//LIkewise, on a Swipe-Up gesture, the Calendar View will return to its original size, occupying only a third of the screen.


#import "SNRViewController.h"
#import "SNREvent.h"
#import "SNRCustomAgendaViewCell.h"
#import "SNRWeatherObject.h"

@interface SNRViewController ()

//manages the array of dates - manages dates
@property (nonatomic, strong) NSMutableArray *datesArrayMutable;
@property (nonatomic, strong) NSArray *datesArray;
@property (nonatomic, strong) NSMutableArray *datesArrayStringsMutable;

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) NSIndexPath *previouslySelectedDateIndexPath;

//manages calendar events
@property (strong, nonatomic) NSMutableDictionary *calendarEvents;
@property (strong, nonatomic) NSDate *dateAtTopHeaderOfAgendaView;

@end

@implementation SNRViewController

/*
    Purpose:
        Populates the events in the agenda view
    responsibility:
        creates the events; this class has too many responsibilities; violates the separation of concerns principle
        each class should only do one and one thing
        the view controller should not become overbloated
 */
- (void)populateEvents{
    
    /*
        Initialize the mutable dictionary which will be used to hold the key
        value entries of {key = eventDate, value = [array containing all the
        events on that date]}
    */
    self.events = [[NSMutableDictionary alloc] init];

    //Initialize the date formatter according to the US locale
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:locale];
    
    
    //Create events for January 1, 2012
    
    NSDate *jan1Date = [dateFormatter dateFromString:@"2012.01.01"];
    
    SNREvent *dinner = [[SNREvent alloc]initWithEventName:@"Team Dinner" date:jan1Date time:@"7:00 pm" duration:@"2h" location:@"Tom's Diner" icon:@"food.png"];
    
    NSArray *jan1Events = @[dinner];
    
    
    //Create events for January 11, 2012
    
    NSDate *jan11Date = [dateFormatter dateFromString:@"2012.01.11"];
    
    SNREvent *holidayDefendersDay = [[SNREvent alloc]initWithEventName:@"Defender's Day" date:jan11Date time:@"ALL DAY" duration:@"ALL DAY" location:@"United States" icon:@"vacation.png"];
    
    SNREvent *concertKingsOfLeon = [[SNREvent alloc]initWithEventName:@"Kings of Leon" date:jan11Date time:@"7:00 am" duration:@"1h30m" location:@"Central Park" icon:@"concert.png"];
    
    SNREvent *tvShow = [[SNREvent alloc]initWithEventName:@"The WAN Show" date:jan11Date time:@"7:30 pm" duration:@"2h30m" location:@"http://www.twitch.tv/linus" icon:@"tv.png"];
    
    NSArray *jan11Events = @[holidayDefendersDay, concertKingsOfLeon, tvShow];
    
    
    //Create events for January 12, 2012
    
    NSDate *jan12Date = [dateFormatter dateFromString:@"2012.01.12"];
    
    SNREvent *talhaBirthday = [[SNREvent alloc]initWithEventName:@"Talha's Birthday" date:jan12Date time:@"ALL DAY" duration:0 location:@"Toronto" icon:@"party.png"];
    
    SNREvent *concertTaylorSwift = [[SNREvent alloc]initWithEventName:@"Concert" date:jan12Date time:@"8:00 pm" duration:@"3h" location:@"Air Canada Centre, Toronto" icon:@"concert.png"];
    
    SNREvent *doctorsAppt = [[SNREvent alloc]initWithEventName:@"Doctor's Appointment" date:jan12Date time:@"8:00 pm" duration:@"1h" location:@"Mt. Sinai Hospital" icon:@"doctor.png"];
    
    NSArray *jan12Events = @[talhaBirthday, concertTaylorSwift, doctorsAppt];
    
    
    //Create events for January 14, 2012
    
    NSDate *jan14Date = [dateFormatter dateFromString:@"2012.01.14"];
    
    SNREvent *workout = [[SNREvent alloc]initWithEventName:@"Workout" date:jan14Date time:@"7:00 am" duration:@"1h30m" location:@"Goodlife Fitness" icon:@"workout.png"];
    
    NSArray *jan14Events = @[workout];
    
    //Create events for February 25, 2012
    
    NSDate *feb25Date = [dateFormatter dateFromString:@"2012.02.25"];
    
    SNREvent *birthday = [[SNREvent alloc]initWithEventName:@"Ushhud's Birthday" date:feb25Date time:@"ALL DAY" duration:0 location:@"Boston Pizza" icon:@"party.png"];
    
    NSArray *feb25Events = @[birthday];
    
    /*
        Key-value mapping for the NSMutableDictionary of agenda events
     
        A key corresponds to a date
        A value corresponds to the array of events associated with that date
     
        We will now insert each date, and its corresponding array of events, into the NSMutableDictionary self.events
     */
    
    [self.events setValue:jan1Events forKey:@"2012.01.01"];
    [self.events setValue:jan11Events forKey:@"2012.01.11"];
    [self.events setValue:jan12Events forKey:@"2012.01.12"];
    [self.events setValue:jan14Events forKey:@"2012.01.14"];
    [self.events setValue:feb25Events forKey:@"2012.02.25"];

    self.keys = @[@"2012.01.01", @"2012.01.11", @"2012.01.12", @"2012.01.14", @"2012.02.25"];
    
}

-(void)populateCalendarArray
{
    
    self.datesArrayMutable = [[NSMutableArray alloc] init];
    self.calendarEvents = [[NSMutableDictionary alloc] init];
    
    //Initialize the date formatter according to the US locale
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:locale];
    
    //Set the initial date components to be January 1, 2012
    int year = 2012;
    int month = 1;
    int day = 1;
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    
    NSString *dayString = [[NSString alloc]init];
    NSString *monthString = [[NSString alloc]init];
    NSString *yearString = [NSString stringWithFormat:@"%d", (int)(year)];
    
    /*
     My String Format for the Keys is in the format 2012.01.01, for January 1, 2012, for example.
     
     i.e. For any day or month less than 9, I must prefix it with a '0'. Otherwise, The day or month retrieved from components.month and components.day will not be prefixed with 0.
     
     Prefixing it with 0 is necessary (in the case where the int value of month or day is less than 9), in order so that I can create a string in the exact same format as that in my Keys array.
     */
    if (day <= 9){
        dayString = @"0";
        dayString = [dayString stringByAppendingString:[NSString stringWithFormat:@"%d",(int)(day)]];
    }else{
        dayString = [NSString stringWithFormat:@"%d",(int)(day)];
    }
    
    if (month <= 9){
        monthString = @"0";
        monthString = [monthString stringByAppendingString:[NSString stringWithFormat:@"%d",(int)(month)]];
    }else{
        monthString = [NSString stringWithFormat:@"%d",(int)(month)];
    }
    
    //Construct January 1, 2012 in "my aforementioned format", i.e. 2012.01.01
    
    NSString *dateStringInMyFormat = [[NSString alloc] init];
    dateStringInMyFormat = [dateStringInMyFormat stringByAppendingString:yearString];
    dateStringInMyFormat = [dateStringInMyFormat stringByAppendingString:@"."];
    
    dateStringInMyFormat = [dateStringInMyFormat stringByAppendingString:monthString];
    dateStringInMyFormat = [dateStringInMyFormat stringByAppendingString:@"."];
    dateStringInMyFormat = [dateStringInMyFormat stringByAppendingString:dayString];
    
    NSDate *january1st2012 = [dateFormatter dateFromString:dateStringInMyFormat];
    
    //Set the initial date to Jan. 1, 2012
    NSDate *currentDate = january1st2012;
    [self.datesArrayMutable addObject:currentDate];
    
    /*
        This loop populates the datesArrayMutable mutable dates array with the 
        entire calendar for the Calendar Year 2012, by initially starting from Jan 1, 2012, and then subsequently adding one day, each loop iteration at a time, until 365 days have been populated for the 2012 calendar year.
     */
    for (int i = 1; i <= 365; i++) {
        NSDate *tomorrow = [currentDate dateByAddingTimeInterval:(60*60*24)];
        [self.datesArrayMutable addObject:tomorrow];
        currentDate = tomorrow;
    }
    
    self.datesArray = [[NSArray alloc] initWithObjects:self.datesArrayMutable, nil];
    
}

//responsibility: set the calendar view
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *calendarViewCellNib = [UINib nibWithNibName:@"CalendarCellNib" bundle:nil];
    [self.calendarView registerNib:calendarViewCellNib forCellWithReuseIdentifier:@"cvCell"];
    
    //Define the flow layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(50, 50)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.calendarView setCollectionViewLayout:flowLayout];
    [self.calendarView setBackgroundColor:[UIColor clearColor]];
    
    //register the class for use in creating new tableview cells
    [self.agendaView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UINib *agendaViewCellNib = [UINib nibWithNibName:@"SNRCustomAgendaViewCell" bundle:nil];
    [self.agendaView registerNib:agendaViewCellNib forCellReuseIdentifier:@"SNRCustomAgendaViewCell"];
    
    //Populate the events in the Agenda View
    [self populateEvents];
    
    //Populate the calendar array for the 2012 Calendar Year
    [self populateCalendarArray];
    
    //Create and add the appropriate swipe gesture recognizers to the Calendar view (collection-view)
    
    //Create a swipe-down gesture, which is used when the user swipes down on the calendar view, thereby allowing the calendar view to expand to a larger display
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeDown:)];
    swipeDown.numberOfTouchesRequired = 1;
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    
    //Create a swipe-up gesture, which is used when the user swipes up on the calendar view, thereby allowing the calendar view to shrink to its original size
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeUp:)];
    swipeUp.numberOfTouchesRequired = 1;
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    
    //Add the gesture recognizers to the Calendar View (collection-view)
    [self.calendarView addGestureRecognizer:swipeDown];
    [self.calendarView addGestureRecognizer:swipeUp];
    
}

/*
    Purpose:
        Vertically expands the calendar view on a swipe-down gesture
 */
-(void)didSwipeDown: (UISwipeGestureRecognizer*) recognizer {
    
    //Enable scrolling and paging on the Calendar view
    self.calendarView.scrollEnabled = TRUE;
    self.calendarView.pagingEnabled = TRUE;
    
    //On a swipe-down, expand the calendar view height to 200 units
    self.calendarViewHeight.constant = 200;
    
}

/*
    Purpose:
        Vertically shrinks the calendar view on a swipe-up gesture
 */
-(void)didSwipeUp: (UISwipeGestureRecognizer*) recognizer {
    
    //Disable scrolling and paging on the Calendar view
    self.calendarView.scrollEnabled = FALSE;
    self.calendarView.pagingEnabled = FALSE;
    
    //On a swipe-up, shrink the calendar view height to 100 units
    self.calendarViewHeight.constant = 100;
    
}

-(NSString*)getMonthString:(NSInteger)monthValue{
    NSString *monthString;
    
    switch (monthValue) {
        case 1:
            monthString = @"Jan";
            break;
            
        case 2:
            monthString = @"Feb";
            break;
            
        case 3:
            monthString = @"Mar";
            break;
            
        case 4:
            monthString = @"Apr";
            break;
            
        case 5:
            monthString = @"May";
            break;
            
        case 6:
            monthString = @"Jun";
            break;
            
        case 7:
            monthString = @"Jul";
            break;
            
        case 8:
            monthString = @"Aug";
            break;
            
        case 9:
            monthString = @"Sept";
            break;
            
        case 10:
            monthString = @"Oct";
            break;
            
        case 11:
            monthString = @"Nov";
            break;
            
        case 12:
            monthString = @"Dec";
            break;
            
        default:
            break;
    }
    
    return monthString;
}

#pragma mark - collection view methods

/*
    Purpose:
        Returns a cell in the collection-view for the given index path
 
    References:
    For this method, I adopted code from the Collection View tutorial available at:
    http://adoptioncurve.net/archives/2012/09/a-simple-uicollectionview-tutorial/
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSMutableArray *data = self.datesArray[indexPath.section];
    
    //get the date at the appropriate row
    NSDate* date = data[indexPath.row];
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSCalendarUnit units = (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitWeekday);
    
    NSDateComponents *dayComponents = [calendar components:units fromDate:date];
    
    NSInteger dayValue = [dayComponents day];
    NSInteger monthValue = [dayComponents month];
    
    NSInteger cellDataInteger = dayValue;
    
    bool firstDayOfMonth = (dayValue == 1);
    
    NSString *dayString = [NSString stringWithFormat:@"%ld", (long)cellDataInteger];
    
    NSString *monthString = [self getMonthString:monthValue];
    
    static NSString *cellIdentifier = @"cvCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UILabel *dayLabel = (UILabel *)[cell viewWithTag:100];
    UILabel *monthLabel = (UILabel *)[cell viewWithTag:150];
    UIImageView *blueCircleImage = (UIImageView *)[cell viewWithTag:250];
    
    monthLabel.hidden = YES;
    blueCircleImage.hidden = YES;
    
    [dayLabel setText:dayString];
    [monthLabel setText:monthString];
    
    if (firstDayOfMonth){
        monthLabel.hidden = NO;
        [dayLabel setTextColor:[UIColor redColor]];
    }else{
        [dayLabel setTextColor:[UIColor blackColor]];
    }
    
    if (cell.selected)
    {
        blueCircleImage.hidden = NO;
        self.previouslySelectedDateIndexPath = indexPath;
        
    }
    else{
        blueCircleImage.hidden = YES;
    }
    
    return cell;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //Retrieve the index paths for the currently visible rows in the agenda view (TableView); these are the currently visible agenda events
    NSArray *visibleEvents = [self.agendaView indexPathsForVisibleRows];
    
    if ([visibleEvents count] > 0){
        
        //Retrieve the event / row at the top of the agenda view; this will allow us to subsequently highlight the corresponding cell in the Calendar View (Collection View)
        NSIndexPath *topMostEventInAgendaView = visibleEvents[0];
        
        //Find the date of the event at the top-most visible row in the agenda view
        
        int topMostEventSection = topMostEventInAgendaView.section;
        
        //Retrieves the key (a date string) for the event at the top-most section
        NSString *key = self.keys[topMostEventSection];

        //Initialize the date formatter according to the US locale
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
        
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:locale];
        
        
        //Create events for January 1, 2012
        
        NSDate *date = [dateFormatter dateFromString:key];
        
        NSMutableArray *arrayOneElementMutable = [[NSMutableArray alloc] init];
        [arrayOneElementMutable addObject:date];
        
        //Retrieves the array of events associated with the date currently present at the top header of the Agenda View (Table View)
        NSArray *array = [self.events objectForKey:key];
        
        //Retrieves the event at the 0th index of the array of events associated with the date currently present at the top header of the Agenda View (Table View); we could have chosen any arbitrary index between 0 and [array count], as the date for all of the events in this range would be the same
        SNREvent *eventAtTop = array[0];
        
        //Retrieve the date associated with the header at the top of the visible Agenda View (Table View)
        NSDate *dateEventAtTop = eventAtTop.eventDate;
        
        NSArray *datesArrayAtZero = [self.datesArray objectAtIndex:0];
        
        int indexOfDateInDatesArray = [datesArrayAtZero indexOfObject:dateEventAtTop];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:indexOfDateInDatesArray inSection:0];
        
        UICollectionViewCell *cell = [self.calendarView cellForItemAtIndexPath:indexPath];
        
        UIImageView *blueCircleImage = (UIImageView *)[cell viewWithTag:250];
        blueCircleImage.hidden = NO;
        
        [self unselectCellAtIndexPath:self.previouslySelectedDateIndexPath];
    
        self.previouslySelectedDateIndexPath = indexPath;
        
        [self.calendarView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.datesArray count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    NSMutableArray *sectionArray = [self.datesArray objectAtIndex:section];
    return [sectionArray count];
}

/*
    Returns the size of one collection view cell
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    CGFloat cellWidth = screenWidth/7;
    CGFloat cellHeight = screenWidth/7;
    
    return CGSizeMake(cellWidth, cellHeight);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

-(void)unselectCellAtIndexPath:(NSIndexPath*)indexPath
{
    UICollectionViewCell *currentlySelectedDateCell = [self.calendarView cellForItemAtIndexPath:indexPath];
    
    UIImageView *blueCircleImage = (UIImageView *)[currentlySelectedDateCell viewWithTag:250];
    blueCircleImage.hidden = YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *datesArray = [self.datesArray objectAtIndex:indexPath.section];
    
    //Get the date at the appropriate row
    NSDate* date = datesArray[indexPath.row];
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSCalendarUnit units = (NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay);
    
    // Get necessary date components
    NSDateComponents* components = [calendar components:units fromDate:date];
    
    NSInteger month = components.month;  //gives you month
    NSInteger day = components.day;
    NSInteger year = components.year;
    
    NSString *dayString = [[NSString alloc]init];
    NSString *monthString = [[NSString alloc]init];
    NSString *yearString = [NSString stringWithFormat:@"%d", (int)(year)];
    
    /*
        My String Format for the Keys is in the format 2012.01.01, for January 1, 2012, for example.
     
        i.e. For any day or month less than 9, I must prefix it with a '0'. The day or month retrieved from components.month and components.day will not be prefixed with 0.
     
        Prefixing it with 0 is necessary (in the case where the int value of month or day is less than 9), in order so that I can create a string in the exact same format as that in my Keys array.
     */
    if (day <= 9){
        dayString = @"0";
        dayString = [dayString stringByAppendingString:[NSString stringWithFormat:@"%d",(int)(day)]];
    }else{
        dayString = [NSString stringWithFormat:@"%d",(int)(day)];
    }
    
    if (month <= 9){
        monthString = @"0";
        monthString = [monthString stringByAppendingString:[NSString stringWithFormat:@"%d",(int)(month)]];
    }else{
        monthString = [NSString stringWithFormat:@"%d",(int)(month)];
    }
    
    NSString *dateStringInMyFormat = [[NSString alloc] init];
    dateStringInMyFormat = [dateStringInMyFormat stringByAppendingString:yearString];
    dateStringInMyFormat = [dateStringInMyFormat stringByAppendingString:@"."];
    
    dateStringInMyFormat = [dateStringInMyFormat stringByAppendingString:monthString];
    dateStringInMyFormat = [dateStringInMyFormat stringByAppendingString:@"."];
    dateStringInMyFormat = [dateStringInMyFormat stringByAppendingString:dayString];
    
    NSInteger indexOfDateInKeysArray = [self.keys indexOfObject:dateStringInMyFormat];
    
    NSInteger sectionInTableView = indexOfDateInKeysArray;
    
    //scroll to the first row in the given date
    NSInteger rowInTableView = 0;
    
    NSIndexPath *indexPathOfDateInTableView = [NSIndexPath indexPathForRow:rowInTableView inSection:sectionInTableView];
    
    UICollectionViewCell *dateCell = [self.calendarView cellForItemAtIndexPath:indexPath];
    
    //unselect the currently selected cell
    
    if (self.previouslySelectedDateIndexPath){
        [self unselectCellAtIndexPath:self.previouslySelectedDateIndexPath];
    }
    
    UIImageView *blueCircleImage = (UIImageView *)[dateCell viewWithTag:250];
    
    if (dateCell.selected)
    {
        
        blueCircleImage.hidden = NO;
        self.previouslySelectedDateIndexPath = indexPath;
    }
    else{
        blueCircleImage.hidden = YES;
    }
    
    [self.agendaView scrollToRowAtIndexPath:indexPathOfDateInTableView atScrollPosition:(UITableViewScrollPositionTop) animated:YES];

}


#pragma mark - table view functions

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //get a generic date at the given section
    NSString *genericDate = [_keys objectAtIndex:section];
    
    //get the array of events for the selected date, from the events NSMutableDictionary
    NSArray *eventsInOneDay = [self.events objectForKey:genericDate];
    
    //the number of rows in that section corresponds to the count of the array
    return [eventsInOneDay count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    NSString *dateString = self.keys[section];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];

    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:units fromDate:date];
    
    NSInteger weekdayValue = [components weekday];
    NSString *weekdayString = @"";
    
    switch (weekdayValue) {
        case 1:
            weekdayString = @"Sunday";
            break;
            
        case 2:
            weekdayString = @"Monday";
            break;
        
        case 3:
            weekdayString = @"Tuesday";
            break;
            
        case 4:
            weekdayString = @"Wednesday";
            break;
            
        case 5:
            weekdayString = @"Thursday";
            break;
            
        case 6:
            weekdayString = @"Friday";
            break;
            
        case 7:
            weekdayString = @"Saturday";
            break;
            
        default:
            break;
    }
    
    NSInteger monthValue = [components month];
    NSString *monthString = [self getMonthString:monthValue];
    
    NSString *dayString = [NSString stringWithFormat: @"%ld", (long)[components day]];
    
    NSString *dateStringFullText = @"";
    dateStringFullText = [dateStringFullText stringByAppendingString:weekdayString];
    dateStringFullText = [dateStringFullText stringByAppendingString:@", "];
    dateStringFullText = [dateStringFullText stringByAppendingString:monthString];
    dateStringFullText = [dateStringFullText stringByAppendingString:@ " "];
    dateStringFullText = [dateStringFullText stringByAppendingString:dayString];
    
    return dateStringFullText;
}

/*
 
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return the number of date entries in the dictionary
    return [self.events count];
}

/*
    Purpose: Returns the table cell at the specified index path
    Parameters:
        indexPath - the index path locating the row in the table view
    Returns: 
        the table cell at the specified index path
    Side effects:
        none
 */
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SNRCustomAgendaViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SNRCustomAgendaViewCell" forIndexPath:indexPath];
    
    //retrieve the selected date
    NSString *day = [_keys objectAtIndex:[indexPath section]];
    
    //retrieve the appropriate event at the selected date
    SNREvent *event = [[self.events objectForKey:day] objectAtIndex:[indexPath row]];
    
    //set the values for each of the event attributes inside each Agenda View Cell
    cell.eventName.text = event.eventName;
    cell.eventTime.text = event.eventTime;

    cell.eventDuration.text = event.eventDuration;
    cell.eventLocation.text = event.eventLocation;
    cell.eventIcon.image = [UIImage imageNamed:event.eventIcon];
    
    return cell;
}

@end