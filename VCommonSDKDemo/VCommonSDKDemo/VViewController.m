//
//  VViewController.m
//  VCommonSDKDemo
//
//  Created by kevin on 2/15/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#import "VViewController.h"
#import "QHTTPOperation.h"

@interface VViewController ()<UITableViewDataSource,UITableViewDelegate,QHTTPOperationDelegate>
{

    long long dataCount;
}

@property (strong,nonatomic) NSURLConnection* connection;
@property (strong,nonatomic) QHTTPOperation* operation;

@end

@implementation VViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString* s = @"abcw王位";
    
    if ([s hasChineseCharacter]) {
        NSLog(@"I have chinese!");
    }
    

   //Asyn download
    self.operation = [[QHTTPOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.fecoo.com/bestwallpapers/1366x768/free-download-high-definition-apple-logo-wallpaper-for-iphone-download-60553.html"]]];
    self.operation.delegate = self;
    
    [[NSOperationQueue mainQueue] addOperation:self.operation];
}

- (void)operation:(QHTTPOperation *)op didSendBodyData:(long long)totalBytesWritten total:(long long)totalBytesExpectedToWrite{
    NSLog(@"send: %ld %ld",(long)totalBytesExpectedToWrite,(long)totalBytesWritten);
}

- (void)operation:(QHTTPOperation *)op didReadData:(long long)totalBytesRead total:(long long)totalBytesExpectedToRead{
    NSLog(@"receive: %ld %ld",(long)totalBytesRead,(long)totalBytesExpectedToRead);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource & UITableViewDataDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: //VProgressHUD
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"VProgressHUD";
        }
            break;
        case 1: //Drag and auto increase UITextView
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"Drag and auto increase UITextView";
        }
            break;
            
        default:
            break;
    }
}



- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0://VProgressHUD
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [self performSegueWithIdentifier:@"pushToVProgressHUD" sender:self];
        }
            break;
        case 1://Drag and auto increase UITextView
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [self performSegueWithIdentifier:@"pushToDragAndAutoIncreaseUITextView" sender:self];
        }
            break;
            
        default:
            break;
    }
}


#pragma NSURLConnectionDelegate

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response{

    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    dataCount = 0;
    NSLog(@"didReceiveResponse  %lld",[response expectedContentLength]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    dataCount += [data length];
        NSLog(@"didReceiveData  %d",[data length]);
}


- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{

}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

        NSLog(@"connectionDidFinishLoading  dataLength: %lld",dataCount);
}

@end
