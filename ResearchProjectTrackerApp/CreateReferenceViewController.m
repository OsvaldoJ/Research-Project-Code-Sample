//
//  CreateReferenceViewController.m
//  ResearchProjectTrackerApp
//
//  Created by Lucas Damian Napoli on 02/10/14.
//  Copyright (c) 2014 microsoft. All rights reserved.
//

#import "CreateReferenceViewController.h"
#import "ProjectClient.h"
#import "Reference.h"
#import "office365-base-sdk/OAuthentication.h"

@interface CreateReferenceViewController ()

@end

@implementation CreateReferenceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createReference:(id)sender {
    [self createReference];
}

-(void)createReference{
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135,140,50,50)];
    spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:spinner];
    spinner.hidesWhenStopped = YES;
    
    [spinner startAnimating];
    
    ProjectClient* client = [self getClient];
    
    Reference* newReference = [[Reference alloc] init];
    newReference.title = @"";
    newReference.url = self.referenceUrlTxt.text;
    newReference.comments = self.referenceDescriptionUrl.text;
    
    NSURLSessionTask* task = [client addReference:@"Research References" item:newReference callback:^(BOOL success, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
    [task resume];
}

-(ProjectClient*)getClient{
    OAuthentication* authentication = [OAuthentication alloc];
    [authentication setToken:self.token];
    
    return [[ProjectClient alloc] initWithUrl:@"https://foxintergen.sharepoint.com/ContosoResearchTracker"
                                  credentials: authentication];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
