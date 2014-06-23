//
//  YelpCell.h
//  yelpClient
//
//  Created by Pravin Neema on 6/18/14.
//  Copyright (c) 2014 Pravin Neema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YelpCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *singleReview;
@property (strong, nonatomic) NSMutableDictionary *staticImageDictionary;

-(void) setReview:(NSDictionary *) review;
@end
