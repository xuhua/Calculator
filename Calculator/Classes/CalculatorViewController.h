//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Hua Xu on 12/25/10.
//  Copyright Columbia University 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
	IBOutlet UILabel *display;
	IBOutlet UILabel *memory;
	IBOutlet UILabel *DegreeDisp;
	CalculatorBrain *brain;
	BOOL userIsInTheMiddleOfTypingANumber;
	BOOL IsDecimalEntered;
}

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)decimalPressed:(UIButton *)sender;
- (IBAction)backspacePressed:(UIButton *)sender;
- (IBAction)degreeSwitch:(UISwitch *)sender;

@end

