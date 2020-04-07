//
//  HLTCheckListTableViewController.m
//  HealthTap
//
//  Created by Talha Khalid on 1/3/2016.
//  Copyright (c) 2016 Talha Khalid. All rights reserved.
//

#import "HLTCheckListTableViewController.h"
#import "HLTCheckListItem.h"

@interface HLTCheckListTableViewController ()

@property (strong, nonatomic) NSMutableArray *checkListItems;
@property (strong, nonatomic) NSMutableArray *completedItems;
@property (strong, nonatomic) NSMutableArray *unCompletedItems;

@end

@implementation HLTCheckListTableViewController

#pragma mark - Helper methods

- (void)populateCheckList{
    self.checkListItems = [NSMutableArray array];
    self.completedItems = [NSMutableArray array];
    self.unCompletedItems = [NSMutableArray array];
    
    HLTCheckListItem *item1 = [[HLTCheckListItem alloc] init];
    item1.text = @"Take a deep breath";
    item1.frequency = 1;
    item1.completed = false;
    
    HLTCheckListItem *item2 = [[HLTCheckListItem alloc] init];
    item2.text = @"Go for a walk";
    item2.frequency = 2;
    item2.completed = false;
    
    HLTCheckListItem *item3 = [[HLTCheckListItem alloc] init];
    item3.text = @"Hit me in the head";
    item3.frequency = 5;
    item3.completed = true;
    
    [self.checkListItems addObject:item1];
    [self.checkListItems addObject:item2];
    [self.checkListItems addObject:item3];
    
    for (HLTCheckListItem *item in self.checkListItems){
        if (item.completed){
            [self.completedItems addObject:item];
        }else{
            [self.unCompletedItems addObject:item];
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateCheckList];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get the row that was selected
    HLTCheckListItem *selectedItem = self.checkListItems[indexPath.row];
    NSLog(@"Selected item is: %@", selectedItem.text);

    [self.completedItems addObject:[self.checkListItems objectAtIndex:indexPath.row]];
    
    //[self.checkListItems removeObjectAtIndex:indexPath.row];
    
    selectedItem.completed = YES;
    
    UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    //[selectedCell setSelected:YES animated:YES];
    
    //[self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numCompletedItems = 0;
    
    for (HLTCheckListItem *item in self.checkListItems){
        if (item.completed){
            numCompletedItems += 1;
        }
    }
    
    int numUnCompletedItems = 0;
    
    for (HLTCheckListItem *item in self.checkListItems){
        if (!item.completed){
            numUnCompletedItems += 1;
        }
    }
    
    /*
        There are 2 sections in this TableView.
        Section 0 corresponds to the UnCompleted Items in the checklist.
        Section 1 corresponds to the Completed Items in the checklist.
     */
    return (section == 0) ? numUnCompletedItems : numCompletedItems;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    
    HLTCheckListItem *item;
    
    NSInteger section = indexPath.section;
    
    switch (section){
        case 0:         //uncompleted items
            item = [self.unCompletedItems objectAtIndex:indexPath.row];
            break;
        case 1:         //completed items
            item = [self.completedItems objectAtIndex:indexPath.row];
            break;
    }
    
    cell.textLabel.text = item.text;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", item.frequency];
    
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    if (item.completed){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    switch (section){
        case 0:
            sectionName = @"ToDo Items";
            break;
        case 1:
            sectionName = @"Completed Items";
            break;
        default:
            sectionName = @"";
            break;
    }
    
    return sectionName;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
