//
//  CustomTableCell.h
//  NBA Players
//
//  Created by James McPherson on 11/18/13.
//  Copyright (c) 2013 James McPherson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell

// Define UITextViews
@property (weak, nonatomic) IBOutlet UILabel* nameLabel;
@property (weak, nonatomic) IBOutlet UILabel* teamLabel;
@property (weak, nonatomic) IBOutlet UILabel* jerseyNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel* yearsLabel;
@property (weak, nonatomic) IBOutlet UILabel* weightLabel;

@end
