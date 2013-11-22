//
//  SQLManager.m
//  NBA Players
//
//  Created by James McPherson on 11/18/13.
//  Copyright (c) 2013 James McPherson. All rights reserved.
//

#import "SQLManager.h"
#import <sqlite3.h>
#import <Parse/Parse.h>

@implementation SQLManager

-(void)createDatabase{
    //Create Directory Path
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE);
    
    //Check for dirPaths
    if (dirPaths != nil) {
        //Create string that holds directory
        NSString* documentsDirectory = [dirPaths objectAtIndex:0];
        
        //Create Database Name
        NSString* dbName = @"nbaPlayers.db";
        
        //Create the path
        dbPath = [documentsDirectory stringByAppendingPathComponent:dbName];
        
        //Log the full path
        NSLog(@"Database Path = %@", dbPath);
    }
}

//Function that opens the database
-(void)openDatabase{
    //Create a const char that will be used to open sqlite database
    const char* databasePath = [dbPath UTF8String];
    
    //Open the database
    if (sqlite3_open(databasePath, &dbContext) == SQLITE_OK){
        //Log database open
        NSLog(@"Database OPEN");
    }
}

-(void)createAthleteTable{
    const char* sqlAthleteTableStatement = "CREATE TABLE athletes (id INTEGER PRIMARY KEY NOT NULL UNIQUE, displayName TEXT, team TEXT, jerseyNumber TEXT, yearsPro TEXT, weight TEXT)";
    
    char* error;
    if (sqlite3_exec(dbContext, sqlAthleteTableStatement, NULL, NULL, &error) != SQLITE_OK) {
        NSLog(@"Something Went Wrong with Table Creation!!");
    }
}

-(void)addAthleteToTable:(NSString*)display teamString:(NSString*)teamString jersey:(NSString*)jersey yearsString:(NSString*)yearsString weightString:(NSString*)weightString {
    //Create a statement for inserting data into table
    NSString* insertAthleteString =  [NSString stringWithFormat:@"INSERT INTO athletes (displayName, team, jerseyNumber, yearsPro, weight) VALUES ('%@','%@','%@','%@', '%@')", display, teamString, jersey, yearsString, weightString];
    
    const char* insertAthlete = [insertAthleteString UTF8String];
    //Create Statement
    sqlite3_stmt* compiledInsertStatement;
    
    if (sqlite3_prepare_v2(dbContext, insertAthlete, -1, &compiledInsertStatement, NULL) == SQLITE_OK){
        //sqlite step
        if (sqlite3_step(compiledInsertStatement) == SQLITE_DONE){
            sqlite3_finalize(compiledInsertStatement);
            NSLog(@"Successful Table Addition");
        }
    }
}

-(void)closeDatabase{
    //Close the database
    sqlite3_close(dbContext);
    NSLog(@"Database Closed");
}

-(void)deleteAthlete: (NSString*)display{
    NSString* deleteAthleteString = [NSString stringWithFormat:@"DELETE FROM athletes WHERE displayName = '%@'", display];
    const char* deleteAthlete = [deleteAthleteString UTF8String];
    // Create Statement
    sqlite3_stmt* compiledDeleteStatement;
    if (sqlite3_prepare_v2(dbContext, deleteAthlete, -1, &compiledDeleteStatement, NULL) == SQLITE_OK) {
        sqlite3_finalize(compiledDeleteStatement);
        NSLog(@"Athlete Deleted Successfully");
    }
}

-(NSMutableArray*)onDurantSelect{
    const char* athleteSelectStatement = "SELECT * FROM athletes WHERE displayName = 'Kevin Durant'";
    sqlite3_stmt* compiledSelectStatement;
    NSMutableArray* athleteArray = [[NSMutableArray alloc] init];
    
    // Create Query from Athlete Table in Database
    PFQuery* query = [PFQuery queryWithClassName:@"Athlete"];
    // Set Cache Policy
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    // Populate NSArray with Query Results
    NSArray* allArray = query.findObjects;
    // Loop through results
    for (PFObject* object in allArray){
        // Strings that hold object data
        displayName = [object objectForKey:@"displayName"];
        team = [object objectForKey:@"team"];
        jerseyNumber = [object objectForKey:@"jerseyNumber"];
        yearsPro = [object objectForKey:@"yearsPro"];
        weight = [object objectForKey:@"weight"];
        
        [self addAthleteToTable:displayName teamString:team jersey:jerseyNumber yearsString:yearsPro weightString:weight];
    }
    
    if (sqlite3_prepare_v2(dbContext, athleteSelectStatement, -1, &compiledSelectStatement, nil) == SQLITE_OK) {
        while (sqlite3_step(compiledSelectStatement) == SQLITE_ROW) {
            
            displayName = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 1)];
            team = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 2)];
            jerseyNumber = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 3)];
            yearsPro = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 4)];
            weight = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 5)];
            
            //Log Column Data
            NSLog(@"%@ %@ %@ %@ %@", displayName, team, jerseyNumber, yearsPro, weight);
            
            // Create new instance of Athlete & Set Queried Values to appropriate Table Columns
            athlete = [[Athlete alloc]init];
            //[athlete setObjectId:object.objectId];
            [athlete setDisplayName:displayName];
            [athlete setTeam:team];
            [athlete setJerseyNumber:jerseyNumber];
            [athlete setYearsPro:yearsPro];
            [athlete setWeight:weight];
            // add athlete to NSMutableArray
            [athleteArray addObject:athlete];
        }
    }
    
    NSLog(@"Athlete Array Length is %i", athleteArray.count);
    return athleteArray;
}

-(NSMutableArray*)onAllSelect{
    const char* athleteSelectStatement = "SELECT * FROM athletes";
    sqlite3_stmt* compiledSelectStatement;
    NSMutableArray* athleteArray = [[NSMutableArray alloc] init];
    
    // Create Query from Athlete Table in Database
    PFQuery* query = [PFQuery queryWithClassName:@"Athlete"];
    // Set Cache Policy
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    // Populate NSArray with Query Results
    NSArray* allArray = query.findObjects;
    // Loop through results
    for (PFObject* object in allArray){
        // Strings that hold object data
        displayName = [object objectForKey:@"displayName"];
        team = [object objectForKey:@"team"];
        jerseyNumber = [object objectForKey:@"jerseyNumber"];
        yearsPro = [object objectForKey:@"yearsPro"];
        weight = [object objectForKey:@"weight"];

        [self addAthleteToTable:displayName teamString:team jersey:jerseyNumber yearsString:yearsPro weightString:weight];
    }
    
        if (sqlite3_prepare_v2(dbContext, athleteSelectStatement, -1, &compiledSelectStatement, nil) == SQLITE_OK) {
            while (sqlite3_step(compiledSelectStatement) == SQLITE_ROW) {
                
                displayName = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 1)];
                team = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 2)];
                jerseyNumber = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 3)];
                yearsPro = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 4)];
                weight = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 5)];
                
                //Log Column Data
                NSLog(@"%@ %@ %@ %@ %@", displayName, team, jerseyNumber, yearsPro, weight);
                
                // Create new instance of Athlete & Set Queried Values to appropriate Table Columns
                athlete = [[Athlete alloc]init];
                //[athlete setObjectId:object.objectId];
                [athlete setDisplayName:displayName];
                [athlete setTeam:team];
                [athlete setJerseyNumber:jerseyNumber];
                [athlete setYearsPro:yearsPro];
                [athlete setWeight:weight];
                // add athlete to NSMutableArray
                [athleteArray addObject:athlete];
            }
        } 
    
    NSLog(@"Athlete Array Length is %i", athleteArray.count);
    return athleteArray;
}

-(NSMutableArray*)onHoustonSelect{
    const char* athleteSelectStatement = "SELECT * FROM athletes WHERE team = 'Houston Rockets'";
    sqlite3_stmt* compiledSelectStatement;
    NSMutableArray* athleteArray = [[NSMutableArray alloc] init];
    
    // Create Query from Athlete Table in Database
    PFQuery* query = [PFQuery queryWithClassName:@"Athlete"];
    // Set Cache Policy
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    // Populate NSArray with Query Results
    NSArray* allArray = query.findObjects;
    // Loop through results
    for (PFObject* object in allArray){
        // Strings that hold object data
        displayName = [object objectForKey:@"displayName"];
        team = [object objectForKey:@"team"];
        jerseyNumber = [object objectForKey:@"jerseyNumber"];
        yearsPro = [object objectForKey:@"yearsPro"];
        weight = [object objectForKey:@"weight"];
        
        [self addAthleteToTable:displayName teamString:team jersey:jerseyNumber yearsString:yearsPro weightString:weight];
    }
    
    if (sqlite3_prepare_v2(dbContext, athleteSelectStatement, -1, &compiledSelectStatement, nil) == SQLITE_OK) {
        while (sqlite3_step(compiledSelectStatement) == SQLITE_ROW) {
            
            displayName = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 1)];
            team = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 2)];
            jerseyNumber = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 3)];
            yearsPro = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 4)];
            weight = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(compiledSelectStatement, 5)];
            
            //Log Column Data
            NSLog(@"%@ %@ %@ %@ %@", displayName, team, jerseyNumber, yearsPro, weight);
            
            // Create new instance of Athlete & Set Queried Values to appropriate Table Columns
            athlete = [[Athlete alloc]init];
            //[athlete setObjectId:object.objectId];
            [athlete setDisplayName:displayName];
            [athlete setTeam:team];
            [athlete setJerseyNumber:jerseyNumber];
            [athlete setYearsPro:yearsPro];
            [athlete setWeight:weight];
            // add athlete to NSMutableArray
            [athleteArray addObject:athlete];
        }
    }
    
    NSLog(@"Athlete Array Length is %i", athleteArray.count);
    return athleteArray;
}

@end
