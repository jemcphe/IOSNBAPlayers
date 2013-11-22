//
//  AthleteDetailViewController.h
//  NBA Players
//
//  Created by James McPherson on 11/18/13.
//  Copyright (c) 2013 James McPherson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLManager.h"

@interface AthleteDetailViewController : UIViewController
{
    // Define UI Elements
    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* teamLabel;
    IBOutlet UILabel* jerseyNumberLabel;
    IBOutlet UILabel* yearsLabel;
    IBOutlet UILabel* weightLabel;
    
    IBOutlet UIButton* editButton;
    IBOutlet UIButton* deleteButton;
    
    SQLManager* sqlManager;
}

// Define Global Strings that will hold data retrieved from previous ViewController
@property (strong, nonatomic) NSString* objectId;
@property (strong, nonatomic) NSString* displayName;
@property (strong, nonatomic) NSString* team;
@property (strong, nonatomic) NSString* jerseyNumber;
@property (strong, nonatomic) NSString* yearsPro;
@property (strong, nonatomic) NSString* weight;

// OnDelete & OnEdit Button Methods
-(IBAction)onDelete:(id)sender;
@end
