//
//  ViewController.h
//  NBA Players
//
//  Created by James McPherson on 11/18/13.
//  Copyright (c) 2013 James McPherson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Athlete.h"
#import <Parse/Parse.h>
#import <sqlite3.h>
#import "SQLManager.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    // Create UI Elements
    IBOutlet UITableView* myTableView;
    IBOutlet UIButton* durantButton;
    IBOutlet UIButton* allButton;
    IBOutlet UIButton* teamButton;
    
    // Athlete Objects & Query
    Athlete* athlete;
    Athlete* item;
    PFQuery* query;
    
    // Arrays to hold query values
    NSArray* allArray;
    NSArray* singleArray;
    NSArray* teamArray;
    
    // Adjustable Array to hold returned athlete values from database
    NSMutableArray* athleteList;
    
    // String to hold objectId for database manipulation
    NSString* objectIdString;
    
    
    
    // SQL stuff
    SQLManager* sqlManager;
    NSArray* dirPaths;
    NSString *dbPath;
    sqlite3 *dbContext;
    
    NSString* displayName;
    NSString* team;
    NSString* jerseyNumber;
    NSString* yearsPro;
    NSString* weight;

    
}

// OnClick function for when buttons are pressed
-(IBAction)onClick:(id)sender;
@end

