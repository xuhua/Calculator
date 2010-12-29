//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Hua Xu on 12/26/10.
//  Copyright 2010 Columbia University. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain

- (void)setOperand:(double)aDouble
{
	operand = aDouble;
}

- (void)performWaitingOperation
{
		if ([@"+" isEqual:waitingOperation]) {
			operand = waitingOperand + operand;
		} else if ([@"*" isEqual:waitingOperation]) {
			operand = waitingOperand * operand;
		} else if ([@"-" isEqual:waitingOperation]) {
			operand = waitingOperand - operand;
		} else if ([@"/" isEqual:waitingOperation]) {
			if (operand) {
				operand = waitingOperand / operand;
			} else {
				errorMessage = @"error_zeroDivide";
			}
		}
}
- (double)performOperation:(NSString *)operation
{
	errorMessage = @"";
	if ([operation isEqual:@"sqrt"]) {
		if (operand >= 0) {
			operand = sqrt(operand);
		} else {
			errorMessage = @"error_sqrt";
		}
	} else if ([@"1/x" isEqual:operation]) {
		if (operand) {
			operand = 1/operand;
		}
	} else if ([@"+/-" isEqual:operation]) {
		operand = - operand;
	} else if ([@"sin" isEqual:operation]) {
		if (IsDegree) {
			operand = sin(operand * 3.1415926 / 180);
		} else {
			operand = sin(operand);
		}
	} else if ([@"cos" isEqual:operation]) {
		if (IsDegree) {
			operand = cos(operand * 3.1415926 / 180);
		} else {
			operand = cos(operand);
		}
	} else if ([@"Store" isEqual:operation]) {
		mem_location = operand;
	} else if ([@"Recall" isEqual:operation]) {
		operand = mem_location;
	} else if ([@"Mem +" isEqual:operation]) {
		mem_location = operand + mem_location;
	} else if ([@"C" isEqual:operation]) {
		operand = 0;
		mem_location = 0;
		waitingOperand = 0;
		waitingOperation = nil;
	} else if ([@"MEMC" isEqual:operation]) {
		mem_location = 0;
	} else {
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand = operand;
		operandtoDisplay = [NSString stringWithFormat:@"%g %@",operand,operation];
	}
	return operand;
}

- (double)exportMem
{
	return mem_location;
}

- (NSString *)exportErrorMessage 
{
	return errorMessage;
}

- (void)setDegreeMode:(BOOL)mode
{
	IsDegree = mode;
}

- (NSString *)exportWaittingOperation
{
	return operandtoDisplay;
}

@end
