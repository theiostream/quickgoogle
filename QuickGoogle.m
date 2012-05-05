// coded by theiostream
// Google fix by @fr0st -- code taken from iAndroid.

#import <UIKit/UIKit.h>
#import <libactivator.h>

@interface QGActivator : NSObject <LAListener, UIAlertViewDelegate, UITextFieldDelegate> {
	UIAlertView *searchAlert;
	UITextField *searchField;
}
@end

@interface UIAlertView (QuickGoogle)
- (void)addTextFieldWithValue:(NSString *)value label:(id)label;
- (UITextField *)textFieldAtIndex:(NSUInteger)index;
@end

@interface UIApplication (QuickGoogle)
- (void)applicationOpenURL:(id)url;
@end

// From StatusGoogle (yeah, I rewrote it before quickgoogle)
static NSURL *SGURL(NSString *url) {
	NSArray *arr = [NSArray arrayWithObjects:@"http://",@"https://",@"www.",@".com",@".co",@".net",@".org",@".us",@".me",@".it",@".uk",@".de",@".br",nil];
	for (NSString *k in arr) {
		if ([url rangeOfString:k].location != NSNotFound) {
			NSURL *r = [NSURL URLWithString:url];
			if (![[r scheme] length]) r = [NSURL URLWithString:[@"http://" stringByAppendingString:url]];
			return r;
		}
	}

	return [NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com/search?q=%@&ie=utf-8&oe=utf-8", url]];
}

@implementation QGActivator
- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
	searchAlert = [[[UIAlertView alloc] initWithTitle:@"QuickGoogle!" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Google", nil] autorelease];
	
	[searchAlert addTextFieldWithValue:[NSString string] label:nil];
    searchField = [searchAlert textFieldAtIndex:0];
    [searchField setDelegate:self];
    [searchField setClearButtonMode:UITextFieldViewModeWhileEditing];
	[searchField setKeyboardAppearance:UIKeyboardAppearanceAlert];
	[searchField setAutocorrectionType:UITextAutocorrectionTypeNo];

    [searchAlert show];
	[event setHandled:YES];
}

- (void)alertView:(UIAlertView *)alert willDismissWithButtonIndex:(NSInteger)buttonIndex {
	if ([alert isEqual:searchAlert]) {
		if (buttonIndex == 1) {
			[[UIApplication sharedApplication] applicationOpenURL:SGURL([[searchField text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding])];
		}
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[searchAlert dismissWithClickedButtonIndex:1 animated:YES];
    return YES;
}

+ (void)load {
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"am.theiostre.quickgoogle"];
}
@end