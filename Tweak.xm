#import <UIKit/UIKit.h>
#import "libactivator/libactivator.h"

#define PLIST @"/var/mobile/Library/Preferences/am.theiostre.quickgoogle"

@interface Search : NSObject <LAListener> {

	UITextField* searchField;
}

@end

@implementation Search


- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QuickGoogle!" message:@"TextField goes here" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Google",nil];
	
	searchField = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
	[searchField setBackgroundColor:[UIColor whiteColor]];
	[searchField becomeFirstResponder];
	[alert setTag:1];
	
	[alert addSubview:searchField];
	
	
	[alert show];
	[alert release];
	[searchField release];

	[event setHandled: YES];
	
}


- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
 {
  if ([alert tag] == 1)
    {
		if (buttonIndex == 1) {
			NSString *query = [searchField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			if ([query isEqualToString:@""]) { NSLog(@"no string."); }
else {
			NSString *str = [NSString stringWithFormat:@"http://google.com/?q=%@&ie=utf-8&oe=utf-8", query];
			NSURL *url = [NSURL URLWithString:str];
			[[UIApplication sharedApplication]applicationOpenURL:url];
}
		
		}
	}
}

+ (void)load
{
  [[LAActivator sharedInstance] registerListener:[self new] forName:@"am.theiostre.quickgoogle"];
}

@end