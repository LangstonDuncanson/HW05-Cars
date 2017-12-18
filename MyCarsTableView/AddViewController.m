//
//  AddViewController.m
//  MyCarsTableView
//
//  Created by Lanjoudun on 12/18/17.
//  Copyright © 2017 cop2658.mdc.edu. All rights reserved.

#import "AddViewController.h"
#import "Vehicle+CoreDataClass.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtModel;
@property (weak, nonatomic) IBOutlet UITextField *txtMake;
@property (weak, nonatomic) IBOutlet UITextField *txtYear;
@property (weak, nonatomic) IBOutlet UITextField *txtMPG;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
    
    if (self.aCar) {
        self.txtMake.text = [self.aCar valueForKey:@"make"];
        self.txtModel.text = [self.aCar valueForKey:@"model"];
        
        NSNumber *numericYear = [self.aCar valueForKey:@"year"];
        NSString *year = [NSString stringWithFormat:@"%@", numericYear];
        self.txtYear.text = year;
        
        NSNumber *numericMPG = [self.aCar valueForKey:@"mpg"];
        NSString *mpg = [NSString stringWithFormat:@"%@", numericMPG];
        self.txtMPG.text = mpg;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)saveRecord:(id)sender {
    NSNumberFormatter * f = [[NSNumberFormatter alloc]init];
    if (self.aCar) {
        [self.aCar setValue:self.txtMake.text forKey:@"make"];
        [self.aCar setValue:self.txtModel.text forKey:@"model"];
        
        [f setNumberStyle:NSNumberFormatterNoStyle];
        NSNumber *myYear = [f numberFromString:self.txtYear.text];
        [self.aCar setValue:myYear forKey:@"year"];
        
        
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *myMPG = [f numberFromString:self.txtMPG.text];
        [self.aCar setValue:myMPG forKey:@"mpg"];
        
    }else{
        Vehicle *myCar = [[Vehicle alloc]initWithContext:context];
        [myCar setValue:self.txtMake.text forKey:@"make"];
        [myCar setValue:self.txtModel.text forKey:@"model"];
        
        // format string into a decimal before commiting
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *myMPG = [f numberFromString:self.txtMPG.text];
        [myCar setValue:myMPG forKey:@"mpg"];
        
        // format to appropriate data type
        [f setNumberStyle:NSNumberFormatterNoStyle];
        NSNumber *myYear = [f numberFromString:self.txtYear.text];
        [myCar setValue:myYear forKey:@"year"];
        
        NSLog(@"My Car: %@", myCar);
        
    }

    // zero out the ui fields
    self.txtMake.text = @"";
    self.txtModel.text = @"";
    self.txtMPG.text = @"";
    self.txtYear.text = @"";
    
    NSError *error;
    [context save:&error];
    if( ![context save:&error]){
        NSLog(@"%@ %@" , error, [error localizedDescription]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
