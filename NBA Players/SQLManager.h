//
//  SQLManager.h
//  NBA Players
//
//  Created by James McPherson on 11/18/13.
//  Copyright (c) 2013 James McPherson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Athlete.h"

@interface SQLManager : NSObject
{
    NSString *dbPath;
    NSArray* dirPaths;
    sqlite3* dbContext;
    
    //Strings
    NSString* displayName;
    NSString* team;
    NSString* jerseyNumber;
    NSString* yearsPro;
    NSString* weight;
    
    // Athlete
    Athlete* athlete;
}

-(void)createDatabase;
-(void)openDatabase;
-(void)createAthleteTable;
-(void)addAthleteToTable:(NSString*)display teamString:(NSString*)teamString jersey:(NSString*)jersey yearsString:(NSString*)yearsString weightString:(NSString*)weightString;
-(void)closeDatabase;
-(NSMutableArray*)onDurantSelect;
-(NSMutableArray*)onAllSelect;
-(NSMutableArray*)onHoustonSelect;
-(void)deleteAthlete: (NSString*)display;
@end
