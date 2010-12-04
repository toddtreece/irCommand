//
//  LivingRoomViewController.m
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

#import "LivingRoomViewController.h"
#import "ASIHTTPRequest.h"


@implementation LivingRoomViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)sendCommand:(id)sender {
	UIButton *button = sender;
	NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
	NSURL *url2;
	ASIHTTPRequest *request2;
	int tag = button.tag;
	switch (tag) {
		case 1:
			url2 = [NSURL URLWithString:@"http://example.com:83/?command=poweron"];
			request2 = [[[ASIHTTPRequest alloc] initWithURL:url2] autorelease];
			[request2 setDelegate:self];
			[queue addOperation:request2];
			break;
		case 2:
			url2 = [NSURL URLWithString:@"http://example.com:83/?command=poweroff"];
			request2 = [[[ASIHTTPRequest alloc] initWithURL:url2] autorelease];
			[request2 setDelegate:self];
			[queue addOperation:request2];
			break;
		case 3:
			url2 = [NSURL URLWithString:@"http://example.com:83/?channel=769"];
			request2 = [[[ASIHTTPRequest alloc] initWithURL:url2] autorelease];
			[request2 setDelegate:self];
			[queue addOperation:request2];
			break;
		case 4:
			url2 = [NSURL URLWithString:@"http://example.com:83/?channel=797"];
			request2 = [[[ASIHTTPRequest alloc] initWithURL:url2] autorelease];
			[request2 setDelegate:self];
			[queue addOperation:request2];
			break;	
		case 5:
			url2 = [NSURL URLWithString:@"http://example.com:83/?command=tv_source"];
			request2 = [[[ASIHTTPRequest alloc] initWithURL:url2] autorelease];
			[request2 setDelegate:self];
			[queue addOperation:request2];
			break;	
		case 6:
			url2 = [NSURL URLWithString:@"http://example.com:83/?command=appletv_source"];
			request2 = [[[ASIHTTPRequest alloc] initWithURL:url2] autorelease];
			[request2 setDelegate:self];
			[queue addOperation:request2];
			break;		
		case 7:
			url2 = [NSURL URLWithString:@"http://example.com:83/?command=volumeup"];
			request2 = [[[ASIHTTPRequest alloc] initWithURL:url2] autorelease];
			[request2 setDelegate:self];
			[queue addOperation:request2];
			break;
		case 8:
			url2 = [NSURL URLWithString:@"http://example.com:83/?command=volumedown"];
			request2 = [[[ASIHTTPRequest alloc] initWithURL:url2] autorelease];
			[request2 setDelegate:self];
			[queue addOperation:request2];
			break;
		case 9:
			url2 = [NSURL URLWithString:@"http://example.com:83/?command=mute"];
			request2 = [[[ASIHTTPRequest alloc] initWithURL:url2] autorelease];
			[request2 setDelegate:self];
			[queue addOperation:request2];
			break;			
		default:
			break;
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)dealloc {
    [super dealloc];
}


@end
