//
//  YelpCell.m
//  yelpClient
//
//  Created by Pravin Neema on 6/18/14.
//  Copyright (c) 2014 Pravin Neema. All rights reserved.
//

#import "YelpCell.h"
#import "UIImageView+AFNetworking.h"

@interface YelpCell()

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *milesLabel;
@property (weak, nonatomic) IBOutlet UILabel *noReviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *expCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingView;

@end

@implementation YelpCell

-(void) setReview:(NSDictionary *)review{
    self.singleReview = review;
    
    if(review != nil){        
        self.titleLabel.text = review[@"name"];
        
        NSString *category = @"";
        
        for (int i = 0; i < [review[@"categories"] count]; i++){
            
            if(i > 0){
                category = [category stringByAppendingString: @", "];
            }
            category = [category stringByAppendingString: review[@"categories"][i][0]];
        }
        
        self.categoryLabel.text = category;
        self.noReviewsLabel.text = [NSString stringWithFormat:@"%@ Reviews", review[@"review_count"]];
    
        NSString *imageUrl = review[@"image_url"];
        UIImage *ret = [self imageNamed:imageUrl cache:YES];
        ret = [self makeRoundedImage:ret radius:5.0];
        self.posterView.image = ret;
    
//        self.posterView.alpha = 0.0;
//        [UIView animateWithDuration:5.0 animations:^{
//            self.posterView.alpha = 1.0;
//        }];
        
        NSString *ratingUrl = review[@"rating_img_url"];
        UIImage *ratingImg = [self imageNamed:ratingUrl cache:YES];
        self.ratingView.image = ratingImg;
        
        NSString *distance = [NSString stringWithFormat:@"%.1fmi",([review[@"distance"] floatValue]/1609.344)];
        self.milesLabel.text = distance;
        
        NSArray *displayAddress = review[@"location"][@"display_address"];
        self.addressLabel.text = [displayAddress[0] stringByAppendingString:[NSString stringWithFormat:@", %@",displayAddress[1]]];
        
    }
}

- (UIImage*)imageNamed:(NSString*)imageNamed cache:(BOOL)cache
{
    UIImage* retImage = [self.staticImageDictionary objectForKey:imageNamed];
    if (retImage == nil)
    {
        retImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageNamed]]];
        if (cache)
        {
            if (self.staticImageDictionary == nil)
                self.staticImageDictionary = [NSMutableDictionary new];
            
            if(imageNamed){
                [self.staticImageDictionary setObject:retImage forKey:imageNamed];
            }
        }
    }
    return retImage;
}

-(UIImage *) makeRoundedImage:(UIImage *) image radius: (float) radius
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
