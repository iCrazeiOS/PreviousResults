#import "Tweak.h"

%hook SpringBoard
	- (void)applicationDidFinishLaunching:(id)arg1 {
		%orig;
		[[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(PRHelperClearNotificationReceived:) name:@"com.icrazeandtyler.previousresults-clearnotification" object:nil];
		[[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(PRHelperAddContentNotificationReceived:) name:@"com.icrazeandtyler.previousresults-sendnotification" object:nil];
	}
	%new
	- (void)PRHelperClearNotificationReceived:(id)sender {
		if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Documents/PreviousResults.txt"]) {
			NSString *blankContent = @"";
			[blankContent writeToFile:@"/var/mobile/Documents/PreviousResults.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
		}
	}
	%new
	- (void)PRHelperAddContentNotificationReceived:(NSNotification *)notification {
		if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Documents/PreviousResults.txt"]) {
			[[NSFileManager defaultManager] createFileAtPath:@"/var/mobile/Documents/PreviousResults.txt" contents:nil attributes:nil];
		}
		NSDictionary *PRDictionary = notification.userInfo;
		NSString *selfText = [PRDictionary objectForKey:@"selfText"];
		NSString *content = [NSString stringWithContentsOfFile:@"/var/mobile/Documents/PreviousResults.txt" encoding:NSUTF8StringEncoding error:NULL];
		NSString *newContent = [NSString stringWithFormat:@"%@\n%@", content, selfText];
		if ([content isEqualToString:@""]) {
			[selfText writeToFile:@"/var/mobile/Documents/PreviousResults.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
		} else {
			[newContent writeToFile:@"/var/mobile/Documents/PreviousResults.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
		}
	}
%end
