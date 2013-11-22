//
//  Athlete.m
//  NBA Players
//
//  Created by James McPherson on 11/18/13.
//  Copyright (c) 2013 James McPherson. All rights reserved.
//

#import "Athlete.h"

@implementation Athlete
// Get Object Id
-(NSString*)getObjectId{
    return objectId;
}
// Set Object Id
-(void)setObjectId:(NSString *)objectIdString{
    objectId = objectIdString;
}
// Get Display Name
-(NSString*)getDisplayName{
    return displayName;
}
// Set Display Name
-(void)setDisplayName:(NSString *)displayNameString{
    displayName = displayNameString;
}
// Get Team
-(NSString*)getTeam{
    return team;
}
// Set Team
-(void)setTeam:(NSString *)teamString{
    team = teamString;
}
// Get Jersey Number
-(NSString*)getJerseyNumber{
    return jerseyNumber;
}
// Set Jersey Number
-(void)setJerseyNumber:(NSString *)jerseyNumberString{
    jerseyNumber = jerseyNumberString;
}
// Get Years Pro
-(NSString*)getYearsPro{
    return yearsPro;
}
// Set Years Pro
-(void)setYearsPro:(NSString *)yearsString{
    yearsPro = yearsString;
}
// Get Weight
-(NSString*)getWeight{
    return weight;
}
// Set Weight
-(void)setWeight:(NSString *)weightString{
    weight = weightString;
}

@end
