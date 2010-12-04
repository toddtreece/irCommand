//
//  GuideHeaderView.m
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

#import "GuideHeaderView.h"


@implementation GuideHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		columns = [NSMutableArray arrayWithCapacity:6];
		[columns retain];
    }
    return self;
}
- (void)addColumn:(CGFloat)position {
	[columns addObject:[NSNumber numberWithFloat:position]];
}


- (void)drawRect:(CGRect)rect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	// just match the color and size of the horizontal line
	CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 0.5); 
	CGContextSetLineWidth(ctx, 0.25);
	
	for (int i = 0; i < [columns count]; i++) {
		// get the position for the vertical line
		CGFloat f = [((NSNumber*) [columns objectAtIndex:i]) floatValue];
		CGContextMoveToPoint(ctx, f, 0);
		CGContextAddLineToPoint(ctx, f, self.bounds.size.height);
	}
	
	CGContextStrokePath(ctx);
	
	[super drawRect:rect];}


- (void)dealloc {
	[columns release];
    [super dealloc];
}


@end
