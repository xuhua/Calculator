//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Hua Xu on 12/25/10.
//  Copyright Columbia University 2010. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

- (CalculatorBrain *)brain
{
	if (!brain) {
		brain = [[CalculatorBrain alloc] init];
		return brain;
	}
}
- (IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit = [[sender titleLabel] text];
	if (userIsInTheMiddleOfTypingANumber) {
		[display setText:[[display text] stringByAppendingString:digit]];
	} else {
		[display setText:digit];
		userIsInTheMiddleOfTypingANumber = YES;
	}

}

- (IBAction)operationPressed:(UIButton *)sender
{
	if (userIsInTheMiddleOfTypingANumber) {
		[[self brain] setOperand:[[display text] doubleValue]];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	NSString *operation = [[sender titleLabel] text];
	double result = [[self brain] performOperation:operation];
	[display setText:[NSString stringWithFormat:@"%g", result]];
}

@end
