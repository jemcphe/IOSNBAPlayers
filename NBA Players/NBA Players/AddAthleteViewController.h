//
//  AddAthleteViewController.h
//  NBA Players
//
//  Created by James McPherson on 11/18/13.
//  Copyright (c) 2013 James McPherson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "SQLManager.h"

@interface AddAthleteViewController : UIViewController
{
    // Define UI Elements
    IBOutlet UITextField* displayNameField;
    IBOutlet UITextField* teamField;
    IBOutlet UITextField* jerseyField;
    IBOutlet UITextField* yearsField;
    IBOutlet UITextField* weightField;
    
    UITextField* activeField;
    
    IBOutlet UIButton* addButton;
    
    IBOutlet UIScrollView* scrollView;
    
    // Create Parse Object
    PFObject* athlete;
    
    // SQL Stuff
    SQLManager* sqlManager;
}

// Method for when athlete is added to database
-(IBAction)onAddAthlete:(id)sender;
@end
