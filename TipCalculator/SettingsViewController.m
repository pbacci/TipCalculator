//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Pierpaolo Baccichet on 5/17/14.
//  Copyright (c) 2014 Pierpaolo. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tipLevel1;
@property (weak, nonatomic) IBOutlet UITextField *tipLevel2;
@property (weak, nonatomic) IBOutlet UITextField *tipLevel3;
@property (weak, nonatomic) IBOutlet UILabel *tipLevelLabel1;
@property (weak, nonatomic) IBOutlet UILabel *tipLevelLabel2;
@property (weak, nonatomic) IBOutlet UILabel *tipLevelLabel3;
@property (weak, nonatomic) IBOutlet UIStepper *tipLevelStepper;

// user actions
- (IBAction)tipStepperValueChanged:(id)sender;
- (IBAction)tapAnywhere:(id)sender;
- (void)highlightDefaultTipLevel;

// helper functions
- (void)updateUserDefaults;
- (void)loadUserDefaults;
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)tipStepperValueChanged:(id)sender {
    [self.view endEditing:YES];
    [self updateUserDefaults];
    [self highlightDefaultTipLevel];
}

- (IBAction)tapAnywhere:(id)sender {
    [self.view endEditing:YES];
    [self updateUserDefaults];
    [self highlightDefaultTipLevel];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadUserDefaults];
    [self highlightDefaultTipLevel];
}

- (void)highlightDefaultTipLevel {
    int tipLevel = self.tipLevelStepper.value;
    UIColor *defaultColor = [UIColor blackColor];
    UIColor *selectedColor = [UIColor blueColor];
    self.tipLevel1.textColor = defaultColor;
    self.tipLevel2.textColor = defaultColor;
    self.tipLevel3.textColor = defaultColor;
    self.tipLevelLabel1.textColor = defaultColor;
    self.tipLevelLabel2.textColor = defaultColor;
    self.tipLevelLabel3.textColor = defaultColor;

    // this should be done as a preallocated array but am
    // not too familiar yet with object lifecycle so doint it
    // this way for now
    if (tipLevel == 1) {
        self.tipLevel1.textColor = selectedColor;
        self.tipLevelLabel1.textColor = selectedColor;
    }
    if (tipLevel == 2) {
        self.tipLevel2.textColor = selectedColor;
        self.tipLevelLabel2.textColor = selectedColor;
    }
    if (tipLevel == 3) {
        self.tipLevel3.textColor = selectedColor;
        self.tipLevelLabel3.textColor = selectedColor;
    }
}

- (void)updateUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[self.tipLevel1.text integerValue] forKey:@"tipLevel1"];
    [defaults setInteger:[self.tipLevel2.text integerValue] forKey:@"tipLevel2"];
    [defaults setInteger:[self.tipLevel3.text integerValue] forKey:@"tipLevel3"];
    [defaults setInteger:self.tipLevelStepper.value forKey:@"tipDefaultLevel"];
    [defaults synchronize];
}

- (void)loadUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int tmp_val;

    tmp_val = [defaults integerForKey:@"tipLevel1"];
    if (tmp_val == 0) tmp_val = 10; // default
    self.tipLevel1.text = [NSString stringWithFormat:@"%d", tmp_val];
    tmp_val = [defaults integerForKey:@"tipLevel2"];
    if (tmp_val == 0) tmp_val = 15; // default
    self.tipLevel2.text = [NSString stringWithFormat:@"%d", tmp_val];
    tmp_val = [defaults integerForKey:@"tipLevel3"];
    if (tmp_val == 0) tmp_val = 20; // default
    self.tipLevel3.text = [NSString stringWithFormat:@"%d", tmp_val];

    tmp_val = [defaults integerForKey:@"tipDefaultLevel"];
    if (tmp_val == 0) tmp_val = 2; // default
    self.tipLevelStepper.value = tmp_val;
}

@end
