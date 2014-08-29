//
//  ViewController.m
//  caculator
//
//  Created by Song on 14-3-1.
//  Copyright (c) 2014年 song. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *output;
- (IBAction)cleanAll:(id)sender;
- (IBAction)calculate:(id)sender;
- (IBAction)input0:(id)sender;
- (IBAction)input1:(id)sender;
- (IBAction)input2:(id)sender;
- (IBAction)input3:(id)sender;
- (IBAction)input4:(id)sender;
- (IBAction)input5:(id)sender;
- (IBAction)input6:(id)sender;
- (IBAction)input7:(id)sender;
- (IBAction)input8:(id)sender;
- (IBAction)input9:(id)sender;
- (IBAction)inputDot:(id)sender;
- (IBAction)inputPlus:(id)sender;
- (IBAction)inputMinus:(id)sender;
- (IBAction)inputTimes:(id)sender;
- (IBAction)inputDiv:(id)sender;

- (void)newChar:(char)newChar;
- (void)showResult;
- (void)initial;
- (void)reset;
- (NSObject*)popFromArray:(NSMutableArray*)array;
- (void)pushToArray:(NSMutableArray*)array withObject:(NSObject*)obj;
- (NSString*)doCaculate;
- (int)isOperatorMorePrior:(NSString*)op1 compareToOperator:(NSString*)op2;
- (int)valueOfOperator:(NSString*)operator;
- (void)adjustStackByNewOp:(NSString*)op;
- (void)adjustStackAtLast;
- (NSNumber*)doRealCaculateWithOp:(NSString*)op firstNumber:(NSNumber*)num1 secondNumber:(NSNumber*)num2;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initial];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cleanAll:(id)sender {
    [self reset];
    [self showResult];
}

- (IBAction)calculate:(id)sender {
    if (!isOpAlready) {
        [originArray addObject:[NSNumber numberWithLong:number]];
    } else {
        [originArray removeLastObject];
    }
    content = [self doCaculate];
    [self showResult];
    [self reset];
}

- (NSString*)doCaculate{
    BOOL isNum = true;
    for (NSObject* obj in originArray) {
        if(isNum) {
            [nums addObject:obj];
        } else {
            [self adjustStackByNewOp:(NSString*)obj];
        }
        isNum = !isNum;
    }
    [self adjustStackAtLast];
    return [NSString stringWithFormat:@"%ld",[(NSNumber*)[nums lastObject] longValue]];
}

- (void)adjustStackByNewOp:(NSString*)op {
    if ([ops lastObject] == Nil || [self isOperatorMorePrior:op compareToOperator:[ops lastObject]] > 0) {
        [self pushToArray:ops withObject:op];
    } else {
        [self pushToArray:nums withObject:[self doRealCaculateWithOp:(NSString*)[self popFromArray:ops] firstNumber:(NSNumber*)[self popFromArray:nums] secondNumber:(NSNumber*)[self popFromArray:nums]]];
        [self adjustStackByNewOp:op];
    }
}

- (void)adjustStackAtLast{
    int opCount = [ops count];
    while(opCount-- > 0){
        [self pushToArray:nums withObject:[self doRealCaculateWithOp:(NSString*)[self popFromArray:ops] firstNumber:(NSNumber*)[self popFromArray:nums] secondNumber:(NSNumber*)[self popFromArray:nums]]];
    }
}

- (NSNumber*)doRealCaculateWithOp:(NSString *)op firstNumber:(NSNumber *)num1 secondNumber:(NSNumber *)num2 {
    long ln = [num1 longValue];
    long rn = [num2 longValue];
    switch ([op characterAtIndex:0]) {
        case '+':
            return [NSNumber numberWithLong:rn + ln];
        case '-':
            return [NSNumber numberWithLong:rn - ln];
        case '*':
            return [NSNumber numberWithLong:rn * ln];
        case '/':
            return [NSNumber numberWithLong:rn / ln];
        default:
            break;
    }
    return nil;
}



- (int)isOperatorMorePrior:(NSString *)op1 compareToOperator:(NSString *)op2{
    return [self valueOfOperator:op1] - [self valueOfOperator:op2];
}

- (int)valueOfOperator:(NSString *)operator{
    return ([operator compare:@"+"] == 0 || [operator compare:@"-"] == 0) ? 1 : 2;
}


- (IBAction)input0:(id)sender {
    [self newChar:'0'];
    [self showResult];
}

- (IBAction)input1:(id)sender {
    [self newChar:'1'];
    [self showResult];
}

- (IBAction)input2:(id)sender {
    [self newChar:'2'];
    [self showResult];
}

- (IBAction)input3:(id)sender {
    [self newChar:'3'];
    [self showResult];
}

- (IBAction)input4:(id)sender {
    [self newChar:'4'];
    [self showResult];
}

- (IBAction)input5:(id)sender {
    [self newChar:'5'];
    [self showResult];
}

- (IBAction)input6:(id)sender {
    [self newChar:'6'];
    [self showResult];
}

- (IBAction)input7:(id)sender {
    [self newChar:'7'];
    [self showResult];
}

- (IBAction)input8:(id)sender {
    [self newChar:'8'];
    [self showResult];
}

- (IBAction)input9:(id)sender {
    [self newChar:'9'];
    [self showResult];
}

- (IBAction)inputDot:(id)sender {
    [self newChar:'0'];
    [self showResult];
}

- (IBAction)inputPlus:(id)sender {
    [self newChar:'+'];
}

- (IBAction)inputMinus:(id)sender {
    [self newChar:'-'];
}

- (IBAction)inputTimes:(id)sender {
    [self newChar:'*'];
}


- (IBAction)inputDiv:(id)sender {
    [self newChar:'/'];
}

- (void)newChar:(char)newChar {
    if (newChar >= '0' && newChar <= '9' && count++ < 9) {
        isOpAlready = false;
        number = number * 10 + (newChar - '0');
        content = [NSString stringWithFormat:@"%ld",number];
    } else {
        switch (newChar) {
            case '+':
            case '-':
            case '*':
            case '/':
                if (!isOpAlready) {
                    [originArray addObject:[NSNumber numberWithLong:number]];
                    [originArray addObject:[NSString stringWithFormat:@"%c", newChar]];
                    isOpAlready = true;
                    content = @"0";
                    number = 0;
                    count = 0;
                } else {
                    [originArray replaceObjectAtIndex:[originArray count] - 1 withObject:[NSString stringWithFormat:@"%c", newChar]];
                }
                break;
            default:
                break;
        }
    }
}

- (void)showResult{
    self.output.text = content;
}

- (void)initial{
    content = @"0";
    number = 0;
    count = 0;
    isOpAlready = false;
    originArray = [NSMutableArray array];
    nums = [NSMutableArray array];
    ops = [NSMutableArray array];
}

- (void)reset{
    content = @"0";
    number = 0;
    count = 0;
    isOpAlready = false;
    [originArray removeAllObjects];
    [nums removeAllObjects];
    [ops removeAllObjects];
}

- (NSObject*)popFromArray:(NSMutableArray *)array{
    NSObject *obj = [array lastObject];
    [array removeLastObject];
    return obj;
}

- (void)pushToArray:(NSMutableArray*)array withObject:(NSObject*)obj{
    [array addObject:obj];
}

@end
