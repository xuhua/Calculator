//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Hua Xu on 12/26/10.
//  Copyright 2010 Columbia University. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
	double operand;
	NSString *waitingOperation;
	double waitingOperand;
	double mem_location;
	NSString *errorMessage;
	BOOL IsDegree;
	NSString *operandtoDisplay;
}

- (void)setOperand:(double)aDouble;
- (double)performOperation:(NSString *)operation;
- (double)exportMem;
- (NSString *)exportErrorMessage;
- (void)setDegreeMode:(BOOL)mode;
- (NSString *)exportWaittingOperation;

@end
