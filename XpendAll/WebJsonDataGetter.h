//
//  WebJsonDataGetter.h
//  miniGame
//
//  Created by 趴特萬 on 13/3/28.
//
//

@protocol WebJsonDataGetFinishDelegater <NSObject>
@optional
-(void)doThingAfterWebJsonIsOKFromDelegate;
@end
#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface WebJsonDataGetter : NSObject<ASIHTTPRequestDelegate,UIAlertViewDelegate>{
    ASIHTTPRequest  *webRequest;
}
@property(nonatomic,strong)NSArray *webData;
@property(nonatomic,weak)id<WebJsonDataGetFinishDelegater>delegate;
-(id)initWithURLString:(NSString*)url;
-(void)requestWithURLString:(NSString *)url;
@end
