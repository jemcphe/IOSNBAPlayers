//
//  ViewController.m
//  NBA Players
//
//  Created by James McPherson on 11/18/13.
//  Copyright (c) 2013 James McPherson. All rights reserved.
//

#import "ViewController.h"
#import "AddAthleteViewController.h"
#import "AthleteDetailViewController.h"
#import "Athlete.h"
#import "CustomTableCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Allocate and Initialize the NSMutable Array that will hold Athlete Values from Queried database
    athleteList = [[NSMutableArray alloc] init];
    
    // Log Total # of athletes in database
    NSLog(@"%i", athleteList.count);
    
    //Create Directory Path
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE);
    
    //Check for dirPaths
    if (dirPaths != nil) {
        //Create string that points to Documents directory
        NSString* documentsDirectory = [dirPaths objectAtIndex:0];
        
        //String with Database Name
        NSString* dbName = @"nbaPlayers.db";
        //Create full path string to check against
        NSString* checkPath = [[NSString alloc] initWithFormat:@"%@/%@", documentsDirectory, dbName];
        
        //Create instance of sqlManager
        sqlManager = [[SQLManager alloc] init];
        
        //Create filemanager to check for path directory & file existence
        NSFileManager* defaultManager = [[NSFileManager alloc] init];
        /*
         * Check for File 'nbaPlayers.db' in the Documents Directory.  If file exists, log to system.
         * If does not exist, create the database, open, create movie table, add movies, & close database
         */
        if ([defaultManager fileExistsAtPath:checkPath]) {
            NSLog(@"Database Already Exists");
            [sqlManager openDatabase];
            //            [sqlManager closeDatabase];
        } else {
            NSLog(@"Database Does Not Exist... Creating");
            
            //Execute sqlManager functions
            [sqlManager createDatabase];
            [sqlManager openDatabase];
            [sqlManager createAthleteTable];
        }
    }
}

// OnClick function checks for which button is pressed
-(IBAction)onClick:(id)sender{
    // Tags have been assigned to each button... switching between the 3 filter buttons
    switch ([sender tag]) {
        case 0:
            // SQL Call
            [sqlManager openDatabase];
            [sqlManager createAthleteTable];
            athleteList = [[NSMutableArray alloc] initWithArray:sqlManager.onDurantSelect];
            
            // Reload TableView
            [myTableView reloadData];
            [sqlManager closeDatabase];
            break;
        case 1:
            // SQL Call
            [sqlManager openDatabase];
            [sqlManager createAthleteTable];
            athleteList = [[NSMutableArray alloc] initWithArray:sqlManager.onAllSelect];

            // Reload TableView
            [myTableView reloadData];
            [sqlManager closeDatabase];
            break;
        case 2:
            // SQL Call
            [sqlManager openDatabase];
            [sqlManager createAthleteTable];
            athleteList = [[NSMutableArray alloc] initWithArray:sqlManager.onHoustonSelect];
            
            // Reload TableView
            [myTableView reloadData];
            [sqlManager closeDatabase];
        default:
            break;
    }
}

//Segue Settings
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Declare View Controller Classes
    AddAthleteViewController* addView = (AddAthleteViewController*)[segue destinationViewController];
    AthleteDetailViewController* detailView = (AthleteDetailViewController*)[segue destinationViewController];
    // Create IndexPath that will reflect Which TableView Row was selected
    NSIndexPath* indexPath = [myTableView indexPathForSelectedRow];
    //Check for which segue user initiated
    if ([segue.identifier isEqualToString:@"segueToAddAthlete"]) {
        if (addView != nil) {
            NSLog(@"Transition to AddAthleteViewController");
        }
    } else {
        if (detailView != nil) {
            NSLog(@"Transition to AthleteDetailViewController");
            // Create new instance of Athlete and populate with values from selected row
            item = [athleteList objectAtIndex:indexPath.row];
            // Set objectIdString == objectId from selected row
            objectIdString = item.getObjectId;
            
            // Create local string variables for ease
            NSString* displayNameString = item.getDisplayName;
            NSString* teamString = item.getTeam;
            NSString* jerseyNumberString = item.getJerseyNumber;
            NSString* yearsProString = item.getYearsPro;
            NSString* weightString = item.getWeight;
            
            // pass item values to AthleteDetailViewController
            detailView.objectId = objectIdString;
            detailView.displayName = displayNameString;
            detailView.team = teamString;
            detailView.jerseyNumber = jerseyNumberString;
            detailView.yearsPro = yearsProString;
            detailView.weight = weightString;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Set the height of the TableViewCells
    int height = 70;
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of Athletes in athleteList
    return athleteList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Configure The Cell
    item = [athleteList objectAtIndex:indexPath.row];
    
    //define cell
    CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell != nil) {
        // Set the Custom Cell Labels with appropriate data
        cell.nameLabel.text = [item getDisplayName];
        cell.teamLabel.text = [item getTeam];
        cell.jerseyNumberLabel.text = [item getJerseyNumber];
        cell.yearsLabel.text = [item getYearsPro];
        cell.weightLabel.text = [item getWeight];
    }
    // Return Cell
    return cell;
}

@end
