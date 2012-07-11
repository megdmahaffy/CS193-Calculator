//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Megan Mahaffy on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;

@end


@implementation CalculatorViewController

@synthesize display;
@synthesize allCalculationsLabel;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = [sender currentTitle];
    NSRange range = [self.display.text rangeOfString:@"."];
    
    NSLog(@"digit %@", digit);
    NSLog(@"display %@", self.display.text);

    if (self.userIsInTheMiddleOfEnteringANumber) {
        if (range.location == NSNotFound || ![digit isEqualToString:@"."]) {
            self.display.text = [self.display.text stringByAppendingString:digit];  
        }
           
    } else {
        if([digit isEqualToString:@"."]){
            self.display.text = [self.display.text stringByAppendingString:digit];
        } else {
            self.display.text = digit;                
        }
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }

}
- (IBAction)clearPressed {
    self.display.text = @"0";
    self.allCalculationsLabel.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.brain emptyStack];
    
}
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.allCalculationsLabel.text = [self.allCalculationsLabel.text stringByAppendingString:self.display.text];
    self.allCalculationsLabel.text = [self.allCalculationsLabel.text stringByAppendingString:@" "];
}
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber){
        [self enterPressed];
    }
    NSString *operation = sender.currentTitle;
    self.allCalculationsLabel.text = [self.allCalculationsLabel.text stringByAppendingString:operation];
    self.allCalculationsLabel.text = [self.allCalculationsLabel.text stringByAppendingString:@" "];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

@end
