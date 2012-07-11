//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Megan Graham on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)emptyStack;

@property (readonly) id program;

+ (double)runProgram:(id)program;

+ (NSString *)descriptionOfProgram:(id)program;


@end
