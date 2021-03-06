//
//  UITableView+utils.m
//  helloworldppat
//
//  Created by amadeus on 11/1/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//
#import <Firebase/Firebase.h>

@implementation UIViewController(utils)


-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


-(void)requestIsUrgent:(BOOL)urgency forUser:(NSString*)userID withRequest:(NSString*)request
//-(void)sendrequest:(BOOL)urgency forUser:(NSString*)userID
{
    // Create a reference to a Firebase location
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://bostonhome.firebaseio.com/requests"];
    // Write data to Firebase
   // NSArray *persons = [NSArray arrayWithObjects:@"1","video","timestamp"];
    Firebase *postRef;
    if (urgency == true) {
        postRef = [myRootRef childByAppendingPath: @"UrgentRequests"];
    }
    else {
        postRef = [myRootRef childByAppendingPath: @"NonUrgentRequests"];
    }
    
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];
  
    
    NSDictionary *post1 = @{
                            @"userID": userID,
                            @"text": request,
                            @"timestamp":[NSString stringWithFormat:@"%f", timeInMiliseconds]
                            };
    Firebase *post1Ref = [postRef childByAutoId];
    [post1Ref setValue: post1];
    
   // NSString *postId = post1Ref.name;
    
    //[myRootRef childByAutoId:@"Do you have noms? You'll love Firebase."];
}

@end