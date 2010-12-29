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
	}
	return brain;
}
	
- (IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit = [[sender titleLabel] text];
	if ([@"pi" isEqual:digit]) {
		digit = @"3.1415926";
		[display setText:digit];
		userIsInTheMiddleOfTypingANumber = YES;
	} else if (userIsInTheMiddleOfTypingANumber) {
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
		IsDecimalEntered = NO;
	}
	NSString *operation = [[sender titleLabel] text];
	double result = [[self brain] performOperation:operation];
	NSString *errorMessage = [[self brain] exportErrorMessage];
	if (![errorMessage isEqual:@""]) {
		NSString *message;
		if ([errorMessage isEqual:@"error_sqrt"]) {
			message = @"Can not square root of negative number!";
		} else if ([errorMessage isEqual:@"error_zeroDivide"]) {
			message = @"Can not divide by zero!";
		}
		UIAlertView *alertView = [UIAlertView alloc];
		[alertView initWithTitle:errorMessage message:message delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}
	[display setText:[NSString stringWithFormat:@"%g", result]];
	[ShowTwoOperand setText:[[self brain]exportWaittingOperation]];
	[memory setText:[NSString stringWithFormat:@"%g", [[self brain] exportMem]]];
}

- (IBAction)decimalPressed:(UIButton *)sender
{
	if (!IsDecimalEntered) {
		NSString *point = [[sender titleLabel] text];
		if (userIsInTheMiddleOfTypingANumber) {
			[display setText:[[display text] stringByAppendingString:point]];
		} else {
			[display setText:point];
			userIsInTheMiddleOfTypingANumber = YES;
		}
		IsDecimalEntered = YES;
	}
}

- (IBAction)backspacePressed:(UIButton *)sender
{
	NSUInteger index = [[display text] length];
	/* If length of string showed on label is < 0, we change it to 0*/
	if (index > 1) { 
		if (userIsInTheMiddleOfTypingANumber) {
			[display setText:[[display text] substringToIndex:(index-1)]];
		} else {
			userIsInTheMiddleOfTypingANumber = YES;
		}
		
	} else {
		[display setText:@"0"];
	}
}

- (IBAction)degreeSwitch:(UISwitch *)sender
{
	NSLog(@"%d",sender.on);
	[[self brain] setDegreeMode:sender.on];
	if (sender.on) {
		[DegreeDisp setText:@"Degree"];
	} else {
		[DegreeDisp setText:@"Radians"];
	}
}

@end
