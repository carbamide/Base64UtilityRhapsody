/* Base64Object.h created by josh on Mon 8-Mar-2012 */

#import <AppKit/AppKit.h>

@class AboutPanelWindow;

@interface Base64Object : NSObject
{
	id decodeTextView;
	id decodeButton;
	
	id encodeTextView;
	id encodeButton;
	
	id window;
	id delegate;

	AboutPanelWindow * aboutWindowPanel;
}

-(void)decodeAction:(id)sender;
-(void)encodeAction:(id)sender;
-(void)showAbout:(id)sender;

-(void)resetTextViews:(id)sender;

@end
