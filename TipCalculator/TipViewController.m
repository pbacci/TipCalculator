//
//  TipViewController.m
//  TipCalculator
//
//  Created by Pierpaolo Baccichet on 5/17/14.
//  Copyright (c) 2014 Pierpaolo. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

// user actions
- (IBAction)onTap:(id)sender;
- (IBAction)onEditing:(id)sender;

// helper functions
- (void)updateValues;
- (void)onSettingsButton;
- (void)loadUserDefaults;

@end

@implementation TipViewController

// member variables
NSMutableArray *tipValues;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Generous Tips";
    }

    tipValues = [[NSMutableArray alloc]
                    initWithObjects:@(10), @(15), @(20), nil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadUserDefaults];
    [self updateValues];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)onEditing:(id)sender {
    [self updateValues];
}

- (void)loadUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int tmp_val;

    tmp_val = [defaults integerForKey:@"tipLevel1"];
    if (tmp_val == 0) tmp_val = 10; // default
    [self.tipControl setTitle:[NSString stringWithFormat:@"$%d", tmp_val] forSegmentAtIndex:0];
    [tipValues replaceObjectAtIndex:0 withObject:@(tmp_val)];

    tmp_val = [defaults integerForKey:@"tipLevel2"];
    if (tmp_val == 0) tmp_val = 15; // default
    [self.tipControl setTitle:[NSString stringWithFormat:@"$%d", tmp_val] forSegmentAtIndex:1];
    [tipValues replaceObjectAtIndex:1 withObject:@(tmp_val)];

    tmp_val = [defaults integerForKey:@"tipLevel3"];
    if (tmp_val == 0) tmp_val = 20; // default
    [self.tipControl setTitle:[NSString stringWithFormat:@"$%d", tmp_val] forSegmentAtIndex:2];
    [tipValues replaceObjectAtIndex:2 withObject:@(tmp_val)];

    tmp_val = [defaults integerForKey:@"tipDefaultLevel"];
    if (tmp_val == 0) tmp_val = 1; // default
    self.tipControl.selectedSegmentIndex = tmp_val - 1;
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue] / 100.0;
    float totalAmount = tipAmount + billAmount;

    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end
