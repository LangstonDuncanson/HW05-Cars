//
//  AddViewController.h
//  MyCarsTableView
//
//  Created by Lanjoudun on 12/18/17.
//  Copyright © 2017 cop2658.mdc.edu. All rights reserved.

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AddViewController : UIViewController
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
}
@property (strong) NSManagedObjectModel *aCar;

@end
