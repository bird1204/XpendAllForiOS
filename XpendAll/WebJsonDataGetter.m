//
//  WebJsonDataGetter.m
//  miniGame
//
//  Created by 趴特萬 on 13/3/28.
//
//

#import "WebJsonDataGetter.h"
#import "SVProgressHUD.h"
@implementation WebJsonDataGetter
-(id)init{
    self=[super init];
    if (self) {
        
    }
    return self;
}
-(void)requestWithURLString:(NSString *)url{
    [SVProgressHUD showWithStatus:@"載入中" maskType:SVProgressHUDMaskTypeClear];
    webRequest=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [webRequest setDelegate:self];
    [webRequest startAsynchronous];
}

-(id)initWithURLString:(NSString*)url{
    self=[super init];
    if (self) {
        [self requestWithURLString:url];
    }
    return self;
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    self.webData=[NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:nil];
    NSLog(@"%@",request.responseData);
    NSLog(@"%@",self.webData);
    [self.delegate  doThingAfterWebJsonIsOKFromDelegate];
    [SVProgressHUD dismiss];

}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"Failure");
    [SVProgressHUD dismiss];
    //要教他們
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"BeSure" delegate:nil cancelButtonTitle:@"canel" otherButtonTitles:@"one",@"two", nil];
    [alert setDelegate:self];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            NSLog(@"cancel");
            break;
        case 1:
            NSLog(@"one");
            break;
        default:
            break;
    }
}
@end
