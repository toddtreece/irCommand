//
//  FavoritesTableViewController.m
//  _       _____                                          _ 
// (_)     / ____|                                        | |
//  _ _ __| |     ___  _ __ ___  _ __ ___   __ _ _ __   __| |
// | | '__| |    / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` |
// | | |  | |___| (_) | | | | | | | | | | | (_| | | | | (_| |
// |_|_|   \_____\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|
// 
// irCommand
// Copyright 2010 Todd Treece
// http://unionbridge.org/design/ircommand
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

#import "BedFavoritesTableViewController.h"
#import "GuideHeaderView.h"
#import "IRmoteAppDelegate.h"
#import "ChannelTableViewCell.h"
#import "ASIHTTPRequest.h"

@implementation BedFavoritesTableViewController
@synthesize tableDataSource;
@synthesize channelImageViews;
@synthesize queue;

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if (self = [super initWithStyle:style]) {
 }
 return self;
 }
 */


- (void)viewDidLoad {
    [super viewDidLoad];
	queue = [[NSOperationQueue alloc] init];	
	self.navigationItem.titleView = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80.0, 30.0)] autorelease];
	self.navigationItem.titleView.backgroundColor = [UIColor clearColor];
	GuideHeaderView *cell = [[[GuideHeaderView alloc] initWithFrame:CGRectMake(0, 0, 480, 32)] autorelease];
	self.navigationController.navigationBar.tintColor = [UIColor blackColor]; 
	cell.backgroundColor = [UIColor clearColor];
	[self.navigationController.navigationBar addSubview:cell];
	IRmoteAppDelegate *AppDelegate = (IRmoteAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSArray *tempArray = [[NSArray alloc] init];
	self.tableDataSource = tempArray;
	[tempArray release];
	NSArray *times = [[NSArray alloc] init];
	times = [AppDelegate.data objectForKey:@"times"];
	int i;
	float labelLocation;
	for (i = 0; i < 4; i++) {
		labelLocation = 40 + (i * 110);
		if (i == 0) {
			labelLocation = 40;
		}
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelLocation, 0, 110, 30.0)]; 
		label.font = [UIFont systemFontOfSize:14.0]; 
		label.text = [times objectAtIndex:i];
		label.textAlignment = UITextAlignmentCenter; 
		label.textColor = [UIColor whiteColor];
		label.backgroundColor = [UIColor clearColor];
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight; 
		[cell addSubview:label];
		[label release];
		label = nil;
		[cell addColumn:labelLocation];
	}
	self.tableDataSource = [AppDelegate.data objectForKey:@"bedfavorites"];
	//self.channelImageViews = AppDelegate.channelImageViews;
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableDataSource count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier %i", indexPath.row];
	
	ChannelTableViewCell *cell = (ChannelTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	if (cell == nil) {
		NSDictionary *channel = [self.tableDataSource objectAtIndex:indexPath.row];
		//		UIImage *channelImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[channel objectForKey:@"image"]]]];
		UIImage *channelImage = [UIImage imageNamed:[channel objectForKey:@"image"]];
		
		UIImageView *channelImageView = [[UIImageView alloc] initWithImage:channelImage];
		//UIImageView *channelImageView  = [channelImageViews objectAtIndex:indexPath.row];
		channelImageView.center = CGPointMake(20, 17);
		cell = [[[ChannelTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		[cell addSubview:channelImageView];
		//[channelImage release];
		[channelImageView release];
		UILabel *label = [[UILabel	alloc] initWithFrame:CGRectMake(0, 33, 40, 10)]; 
		label.font = [UIFont systemFontOfSize:8.0]; 
		label.text = [channel objectForKey:@"name"];
		label.textAlignment = UITextAlignmentCenter; 
		label.textColor = [UIColor blackColor]; 
		label.backgroundColor = [UIColor clearColor];
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight; 
		[cell.contentView addSubview:label]; 
		[label release];
		NSArray *shows = [channel objectForKey:@"shows"];
		int length = 0;
		float labelLocation;
		float labelWidth;
		int i;
		for (i = 0; i <= [shows count]; i++) {
			if (length < 4) {
				labelLocation = (40 + ((length) * 110)) + 2;
				if (i == 0) {
					labelLocation = 42;
				}
				if (([[[shows objectAtIndex:i] objectForKey:@"length"] intValue] + length) > 4) {
					labelWidth = (110 * (4 - length)) - 4;
				} else {
					labelWidth = (110 * [[[shows objectAtIndex:i] objectForKey:@"length"] intValue]) - 4;
				}				
				UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelLocation, 0, labelWidth, tableView.rowHeight)]; 
				label.font = [UIFont systemFontOfSize:14.0]; 
				label.text = [[shows objectAtIndex:i] objectForKey:@"title"];
				label.textAlignment = UITextAlignmentCenter; 
				label.textColor = [UIColor blackColor];
				label.backgroundColor = [UIColor clearColor];
				label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight; 
				[cell addSubview:label];
				[label release];
				label = nil;
				[cell addColumn:(labelLocation - 2)];
				int templength = length;
				length = templength + [[[shows objectAtIndex:i] objectForKey:@"length"] intValue];
			}
			
		}
		
	}	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
	NSDictionary *channel = [self.tableDataSource objectAtIndex:indexPath.row];
	NSLog([channel objectForKey:@"number"]);
	ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://example.com:83/?bed_channel=%@",[channel objectForKey:@"number"]]]] autorelease];
	[request setDelegate:self];
	[queue addOperation:request];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)dealloc {
	[queue release];
	[tableDataSource release];
	[channelImageViews release];
    [super dealloc];
}


@end

