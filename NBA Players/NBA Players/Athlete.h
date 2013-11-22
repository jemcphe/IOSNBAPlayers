//
//  Athlete.h
//  NBA Players
//
//  Created by James McPherson on 11/18/13.
//  Copyright (c) 2013 James McPherson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Athlete : NSObject
{
    // String values
    NSString* objectId;
    NSString* displayName;
    NSString* team;
    NSString* jerseyNumber;
    NSString* yearsPro;
    NSString* weight;
}
// Declaring custom getters & setters
- (NSString*)getObjectId;
- (void) setObjectId: (NSString*) objectIdString;

- (NSString*)getDisplayName;
- (void) setDisplayName: (NSString*) displayNameString;

- (NSString*)getTeam;
- (void) setTeam: (NSString*) teamString;

- (NSString*)getJerseyNumber;
- (void) setJerseyNumber: (NSString*) jerseyNumberString;

- (NSString*)getYearsPro;
- (void) setYearsPro: (NSString*) yearsString;

- (NSString*)getWeight;
- (void) setWeight: (NSString*) weightString;

@end
