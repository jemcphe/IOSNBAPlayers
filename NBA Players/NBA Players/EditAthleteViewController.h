//
//  EditAthleteViewController.h
//  NBA Players
//
//  Created by James McPherson on 11/18/13.
//  Copyright (c) 2013 James McPherson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAthleteViewController : UIViewController
{
    // Define UI Elements
    IBOutlet UITextField* displayNameField;
    IBOutlet UITextField* teamField;
    IBOutlet UITextField* jerseyNumberField;
    IBOutlet UITextField* yearsField;
    IBOutlet UITextField* weightField;
    
    UITextField* activeField;
    
    IBOutlet UIButton* editButton;
    
    IBOutlet UIScrollView* scrollView;
    
}

// global Strings for holding passed in data
@property (strong, nonatomic) NSString* objectId;
@property (strong, nonatomic) NSString* displayName;
@property (strong, nonatomic) NSString* team;
@property (strong, nonatomic) NSString* jerseyNumber;
@property (strong, nonatomic) NSString* yearsPro;
@property (strong, nonatomic) NSString* weight;

// OnUpdate Function
-(IBAction)onUpdate:(id)sender;
@end
