//
//  MainViewController.m
//  yelpClient
//
//  Created by Pravin Neema on 6/18/14.
//  Copyright (c) 2014 Pravin Neema. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "YelpCell.h"
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"rpV9hDUU7dCJNrvVz--dDQ";
NSString * const kYelpConsumerSecret = @"6NhI_jwRtSO5qC3Ty6A8qX1zB9M";
NSString * const kYelpToken = @"0EMZbu456e12w4rVHIyznFKaNcXWSFHY";
NSString * const kYelpTokenSecret = @"uaJT_wSvmPDDCgAy5Z-Xeg6GEg0";

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *reviewTableView;
@property (nonatomic, strong) YelpClient *client;
@property (strong, nonatomic) IBOutlet UIButton *filterButton;

@property (nonatomic, strong) NSMutableArray *reviews;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)filterPressed:(id)sender;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self getRestaurantResult:@""];
    }
    return self;
}

-(void) getRestaurantResult:(NSString *) queryString{
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    if(queryString.length == 0){
        queryString = @"Indian";
    }
    
    [self.client searchWithTerm:queryString success:^(AFHTTPRequestOperation *operation, id response) {
        self.reviews = response[@"businesses"];
        [self.reviewTableView reloadData];
        //            NSLog(@"response: %@", self.reviews);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.reviewTableView.delegate = self;
    self.reviewTableView.dataSource = self;
    
    [self.reviewTableView registerNib:[UINib nibWithNibName:@"YelpCell" bundle:nil] forCellReuseIdentifier:@"YelpCell"];
    self.reviewTableView.rowHeight = 100;
    
    self.filterButton.layer.cornerRadius = 5;
    self.filterButton.layer.masksToBounds = YES;
    
    self.filterButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.filterButton.layer.shadowOpacity = 0.9;
    self.filterButton.layer.shadowRadius = 12;
    self.filterButton.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
    
    self.searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YelpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpCell"];
    
    NSDictionary *review;
    review = self.reviews[indexPath.row];

    [cell setReview:review];

    return cell;

}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:true];
    
    UITableViewCell* tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    [tableViewCell setSelected:NO animated:YES]; // <-- setSelected instead of setHighlighted
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString*)searchText{
    NSLog(@"Search :%@",searchText);
    
    [self getRestaurantResult:searchText];
}

- (IBAction)filterPressed:(id)sender {
    NSLog(@"TAp gesture");
    FilterViewController *vc = [[FilterViewController alloc] initWithNibName:@"FilterViewController" bundle:nil];
    
    [self.view endEditing:true];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
