#import "Tweak.h"

%group Hooks
	%hook _TtC10Calculator15CalculatorModel
		- (void) buttonPressed:(long long)arg1 {
			%orig;
			if (arg1 == equalsButton) {
				NSNotification *equalsButtonNotification = [NSNotification notificationWithName:@"equalsButtonNotification" object:self userInfo:nil];
				[[NSNotificationCenter defaultCenter] postNotification:equalsButtonNotification];
			}
		}
	%end
	%hook UILabel
		- (void)setText:(id)arg1 {
			%orig;
			if (addObserver) {
				if ([self.superview class] == objc_getClass("Calculator.DisplayView")) {
					addObserver = NO;
					[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(equalsButtonNotification:) name:@"equalsButtonNotification" object:nil];
				}
			}
		}
		%new
		- (void)equalsButtonNotification:(NSNotification *)notification {
			NSDictionary *userInfoDictionary = @{@"selfText": self.text};
			[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.icrazeandtyler.previousresults-sendnotification" object:nil userInfo:userInfoDictionary];
		}
	%end
	%hook DisplayView
		- (void)layoutSubviews {
			%orig;
			if (addRecognizer) {
				addRecognizer = NO;
				UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapRecognizer:)];
				doubleTapRecognizer.numberOfTapsRequired = 2;
				[self addGestureRecognizer:doubleTapRecognizer];
			}
		}
		%new
		- (void)doubleTapRecognizer:(UITapGestureRecognizer*)sender {
			NSString *content = [NSString stringWithContentsOfFile:@"/var/mobile/Documents/PreviousResults.txt" encoding:NSUTF8StringEncoding error:NULL];
			UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Previous Results" message:content preferredStyle:UIAlertControllerStyleAlert];
			UIAlertAction *clearAction = [UIAlertAction actionWithTitle:@"Clear" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
				[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.icrazeandtyler.previousresults-clearnotification" object:nil];
			}];
			UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
			[alert addAction:clearAction];
			[alert addAction:dismissAction];
			[[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alert animated:YES completion:nil];
		}
	%end
%end

%ctor {
	%init(Hooks, DisplayView=objc_getClass("Calculator.DisplayView"));
}