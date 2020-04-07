IMPORTANT NOTE:

IN THE TOP THIRD OF THE SCREEN, WHEREBY THE LIST OF DATES IS DISPLAYED IN THE CALENDAR VIEW, DO NOT CLICK ON A DATE OTHER THAN {Jan 1, Jan 11, Jan 12, Jan 14, Feb 25}; OTHERWISE THE APPLICATION WILL CRASH.


Sunrise Calendar iPhone Sample Application
Created by Talha Khalid

I created a very basic sample of the Sunrise iPhone application - this sample displays my ability to properly use Collection Views and Table Views.

—

NOTE:
This submission is not my “best” work. It needs great improvements on many fronts:
Code needs to be well documented
The UI needs to be “fixed” such that the blue circle displays properly for a selected date in the Calendar View (CollectionView)
The Calendar View (CollectionView) needs to be better presented; currently, the cells do not display in a well-aligned fashion
The code needs to be refactored to eliminate duplicate code; likewise, duplicate code needs to be moved into its own helper function

BUGS AND DEFECTS:
Currently, the user can only select the following dates in the Calendar View (CollectionView), displayed in the top-third of the screen: Jan 1, Jan 11, Jan 12, Jan 14, Feb 25
Clicking on any other date in the Calendar View (CollectionView) will cause the application to crash; this is a known defect and needs to be addressed by adding further functionality in the code

OVERVIEW:
Without further ado, here is an overview of the sample application!

I created a very basic sample of the Sunrise iPhone application - this sample displays my ability to properly use Collection Views and Table Views.

For the sample, I created a Calendar View, displayed in the top-third of the screen. This Calendar View uses a CollectionView, and is populated with all of the dates for the Calendar Year 2012, starting from Jan 1, 2012 to Dec 31, 2012.

The bottom two-thirds of the application displays the Agenda View, implemented via a Table View. The Agenda View displays events on a particular date. For example, Wed. Jan 11 contains 3 events.

INTERACTION BETWEEN CALENDAR VIEW AND AGENDA VIEW:
The cool functionality in this sample application comes about in the interaction between the Calendar View (CollectionView) and the Agenda View (TableView).

The user is able to click on a date in the Calendar View; the date is subsequently highlighted with a blue image. Once the user clicks on that date, the Agenda View (TableView) scrolls to that particular date.

For example, clicking on Jan 11 in the Calendar View (CollectionView) will cause the Agenda View (TableView) to scroll its rows up such that Wednesday, Jan 11 is the date displayed at the top of the Agenda View; accordingly, the events for Jan 11 are displayed beneath.

Likewise, in a reverse manner, when the user scrolls through the agenda view (table-view), the dates in the calendar view (collection-view) above become highlighted.

Try it out!

Swipe up and down on the calendar view (table view) of events, and you will notice that the date for the day at the very top of the table view becomes highlighted in the collection view (agenda view) above. It’s pretty cool - this interaction between the TableView and CollectionView.

I achieved this interaction via careful usage of index paths and the corresponding delegate methods for TableView and CollectionView.

EXPANDING NATURE OF THE CALENDAR VIEW (CollectionView):
In addition, the Calendar View (CollectionView) visible in the top third of the screen can be expanded.

Simply swipe down on the Calendar View (CollectionView), and you will notice that the Calendar View (CollectionView) occupies roughly more than half of the screen.

You can scroll through this Calendar View from Jan 1 2012 to Dec 31, 2012 in this “expanded” mode.

Be sure that you do not actually select a date in the Calendar View that is not included in the aforementioned set of dates mentioned above in this README file; otherwise, the application will crash. (These dates are Jan 1, Jan 11, Jan 12, Jan 14, Feb 25).

Likewise, on a Swipe-Up gesture, the Calendar View will return to its original size, occupying only a third of the screen.