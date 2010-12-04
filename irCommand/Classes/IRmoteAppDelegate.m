//
//  IRmoteAppDelegate.m
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

#import "IRmoteAppDelegate.h"
#import "ASIHTTPRequest.h"
#import "CJSONDeserializer.h"

@implementation IRmoteAppDelegate

@synthesize window;
@synthesize rootController;
@synthesize livingRoomGuideViewController;
@synthesize data;
@synthesize channelImageViews;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	application.statusBarOrientation = UIInterfaceOrientationLandscapeRight;
	[UIApplication sharedApplication].idleTimerDisabled = YES;
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://example.com/scrape_aol_tv.php"]] autorelease];
	//[request setDelegate:self];
	//[request setDidFinishSelector:@selector(request1done:)];
	//[queue addOperation:request]; 
	[request start];
	if ([request responseString]) {
		NSLog(@"loaded");
		NSData *jsonData = [[request responseString]  dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
		self.data = dictionary;
		NSLog(@"%@",dictionary);

		/*NSArray *channels = [dictionary objectForKey:@"channels"];
		channelImageViews = [[NSMutableArray alloc] initWithCapacity:[channels count]];
		int i;
		for (i = 0; i < [channels count]; i++) {
			//NSLog(@"%d", i);
			NSDictionary *channel = [channels objectAtIndex:i];
			UIImage *channelImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[channel objectForKey:@"image"]]]];
			UIImageView *channelImageView = [[UIImageView alloc] initWithImage:channelImage];
			[channelImageViews insertObject:channelImageView atIndex:i];
			[channelImage release];
			[channelImageView release];
		}*/
	}  
	
	// Override point for customization after application launch
	[window addSubview:rootController.view];
    [window makeKeyAndVisible];
}
/*- (void)request1done:(ASIHTTPRequest *)request {
	if ([request responseString]) {
		NSLog(@"loaded");
		NSData *jsonData = [[request responseString]  dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
		self.data = dictionary;
		NSArray *channels = [dictionary objectForKey:@"channels"];
		channelImageViews = [[NSMutableArray alloc] initWithCapacity:([channels count] + 1)];
		int i;
		for (i = 0; i <= [channels count]; i++) {
			NSDictionary *channel = [channels objectAtIndex:i];
			UIImage *channelImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[channel objectForKey:@"image"]]]];
			UIImageView *channelImageView = [[UIImageView alloc] initWithImage:channelImage];
			[channelImageViews insertObject:channelImageView atIndex:i];
			[channelImage release];
			[channelImageView release];
		}
	}  
}
*/
- (void)dealloc {
    [window release];
	[data release];
	[channelImageViews release];
	[rootController release];
	[livingRoomGuideViewController release];
    [super dealloc];
}


@end
