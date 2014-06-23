//
//  MainViewController.h
//  yelpClient
//
//  Created by Pravin Neema on 6/18/14.
//  Copyright (c) 2014 Pravin Neema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>

-(void) getRestaurantResult:(NSString *) queryString;
@end
