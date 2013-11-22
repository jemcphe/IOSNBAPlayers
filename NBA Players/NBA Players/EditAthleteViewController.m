//
//  EditAthleteViewController.m
//  NBA Players
//
//  Created by James McPherson on 11/18/13.
//  Copyright (c) 2013 James McPherson. All rights reserved.
//

#import "EditAthleteViewController.h"
#import <Parse/Parse.h>
#import "SQLManager.h"

@interface EditAthleteViewController ()

@end

@implementation EditAthleteViewController

// Synthesize Global Variables
@synthesize objectId, displayName, team, jerseyNumber, yearsPro, weight;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Set Values of TextFields to passed Data
    [displayNameField setText:displayName];
    teamField.text = team;
    jerseyNumberField.text = jerseyNumber;
    yearsField.text = yearsPro;
    weightField.text = weight;
    
    // Keyboard observers
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y - (keyboardSize.height-15));
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void) keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

// OnUpdate Method
-(IBAction)onUpdate:(id)sender{
    // Could not get this to function correctly.  Had issues retrieving and passing the Object ID
    
//    // Create query that parses through Athlete Table in Database
//    PFQuery* query = [PFQuery queryWithClassName:@"Athlete"];
//    // Retrieve objects from Athlete Table and pass in a specific ObjectId for data requested
//    [query getObjectInBackgroundWithId:objectId block:^(PFObject *athlete, NSError *error) {
//        // Place value of textfields into athlete object & save to database
//        athlete[@"displayName"] = displayNameField.text;
//        athlete[@"team"] = teamField.text;
//        athlete[@"jerseyNumber"] = jerseyNumberField.text;
//        athlete[@"yearsPro"] = yearsField.text;
//        athlete[@"weight"] = weightField.text;
//        // Save Athlete... if offline, saveEventually will allow for, when data connection is available, saving new data
//        [athlete saveEventually];
//    }];
    // Navigate back to Root View Controller
    [self.navigationController popToRootViewControllerAnimated:TRUE];
    
}

@end
