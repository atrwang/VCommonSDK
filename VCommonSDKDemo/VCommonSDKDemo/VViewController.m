//
//  VViewController.m
//  VCommonSDKDemo
//
//  Created by kevin on 2/15/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#import "VViewController.h"

@interface VViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    long long dataCount;
}

@property (strong,nonatomic) NSURLConnection* connection;

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
    
    self.connection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://devthrift.plaso.cn/conf_record/771_411908955.ilbc"]] delegate:self];
    [self.connection start];
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
    return 1;
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
