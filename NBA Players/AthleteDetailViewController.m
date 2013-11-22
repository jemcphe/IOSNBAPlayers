//
//  AthleteDetailViewController.m
//  NBA Players
//
//  Created by James McPherson on 11/18/13.
//  Copyright (c) 2013 James McPherson. All rights reserved.
//

#import "AthleteDetailViewController.h"
#import <Parse/Parse.h>
#import "Athlete.h"
#import "ViewController.h"
#import "EditAthleteViewController.h"

@interface AthleteDetailViewController ()

@end

@implementation AthleteDetailViewController

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
    
    // Set UILabels with data passed from ViewController
    nameLabel.text = displayName;
    teamLabel.text = team;
    jerseyNumberLabel.text = jerseyNumber;
    yearsLabel.text = yearsPro;
    weightLabel.text = weight;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Custom OnDelete Method
-(IBAction)onDelete:(id)sender{
    // Create Local Array to hold Query Objects
    NSArray* athlete = [[NSArray alloc] init];
    // Query Athlete Table in Database
    PFQuery* query = [PFQuery queryWithClassName:@"Athlete"];
    // Set Cache Policy
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    // Query for objectId
    [query whereKey:@"displayName" equalTo:displayName];
    // Place query results into NSArray
    athlete = query.findObjects;
    
    for (PFObject* object in athlete){
        // Delete the object from Database
        [object deleteEventually];
        // Delete from SQL
        [sqlManager openDatabase];
        [sqlManager deleteAthlete:displayName];
        // Release Current View Controller and navigate to Main View
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}
// Segue Setup
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Create Instance of EditAssociateViewController
    EditAthleteViewController* editView = (EditAthleteViewController*)[segue destinationViewController];
    
    //Check for which segue user initiated
    if ([segue.identifier isEqualToString:@"segueToEditAthlete"]) {
        // Log first name for verification of data being passed
        NSLog(@"%@", displayName);
        
        // Create local string variables
        NSString* objectIdString = objectId;
        NSString* displayString = displayName;
        NSString* teamString = team;
        NSString* jerseyNumberString = jerseyNumber;
        NSString* yearsString = yearsPro;
        NSString* weightString = weight;
        
        // pass item values to EditAssociateViewController
        editView.objectId = objectIdString;
        editView.displayName = displayString;
        editView.team = teamString;
        editView.jerseyNumber = jerseyNumberString;
        editView.yearsPro = yearsString;
        editView.weight = weightString;
    }
}

@end
