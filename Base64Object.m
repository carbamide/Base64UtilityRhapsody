/* Base64Object.m created by josh on Mon 8-Mar-2012 */

#import "Base64Object.h"
#import "Base64.h"
#import "AboutPanel.h"

@implementation Base64Object

-(void)decodeAction:(id)sender
{
	int result;

	NSData * decodedData = [Base64 decode:[decodeTextView string]];
	NSSavePanel * savePanel = [NSSavePanel savePanel];

	if ([[decodeTextView string] length] < 1) {
		return;
	}

	NSBeep();
	
	result = [savePanel runModalForDirectory:NSHomeDirectory() file:nil];

	if (result = NSOKButton) {
		[decodedData writeToFile:[savePanel filename] atomically:YES];
	}
	else {
		return;
	}
}

-(void)encodeAction:(id)sender
{
	int result;

	NSString * startDir = NSHomeDirectory();
	NSString * selectedFile = nil;
        NSString * encodedString = nil;

	NSData * dataFromFile = nil;

	NSPasteboard * pasteboard = [NSPasteboard generalPasteboard];

        NSOpenPanel * openPanel = [NSOpenPanel openPanel];

        result = [openPanel runModalForDirectory:startDir file:nil types:nil];

	if (result = NSOKButton) {
		selectedFile = [[openPanel filenames] objectAtIndex:0];
		
		dataFromFile = [NSData dataWithContentsOfFile:selectedFile];

		encodedString = [Base64 encode:dataFromFile];
		
		[pasteboard setString:encodedString forType:NSStringPboardType];

		[encodeTextView setString:encodedString];
	}
	else {
		NSLog(@"Cancel was pressed.");
	}

}

-(void)resetTextViews:(id)sender
{
	[decodeTextView setString:@""];
	[encodeTextView setString:@""];
}

-(void)showAbout:(id)sender
{
	aboutWindowPanel = [[AboutPanelWindow alloc] initWithWindowNibName:@"About"];
	
	[[aboutWindowPanel window] makeKeyAndOrderFront:self];
}

@end
