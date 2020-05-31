static BOOL addObserver = YES;
static BOOL addRecognizer = YES;

#define clearButton 1
#define swipeResultGesture 2
#define plusSlashMinusButton 3
#define percentButton 4
#define divideButton 5
#define multiplyButton 6
#define minusButton 7
#define plusButton 8
#define equalsButton 9
#define decimalButton 10
#define zeroButton 11
#define oneButton 12
#define twoButton 13
#define threeButton 14
#define fourButton 15
#define fiveButton 16
#define sixButton 17
#define sevenButton 18
#define eightButton 19
#define nineButton 20
#define startBracketButton 21
#define closeBracketButton 22
#define mcButton 23
#define mPlusButton 24
#define mMinusButton 25
#define mrButton 26
#define twoNDButton 27
#define xSquaredButton 28
#define xCubedButton 29
#define xyButton 30
#define exButton 31
#define tenxButton 32
#define oneSlashXButton 33
#define squareRootButton 34
#define cubeRootButton 35
#define yRootButton 36
#define lnButton 37
#define logTenButton 38
#define xExclamationButton 39
#define sinButton 40
#define cosButton 41
#define tanButton 42
#define eButton 43
#define eeButton 44
#define radButton 45
#define sinhButton 46
#define coshButton 47
#define tanhButton 48
#define piButton 49
#define randButton 50
#define allClearButton 51
#define degButton 53

@interface UIView (CalculatorTweak)
@property (nonatomic, copy, readwrite) NSString *text;
@end

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end