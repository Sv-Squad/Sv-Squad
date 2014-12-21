//
//  SQSLoginViewController.m
//  SVSQuad
//
//  Created by 周舟 on 20/12/14.
//  Copyright (c) 2014 zjuCom. All rights reserved.
//

#import "SQSLoginViewController.h"
#import "UMSocial.h"

@interface SQSLoginViewController ()<UMSocialUIDelegate>


@end

@implementation SQSLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)ohterLoginClick:(UIButton *)sender
{
    NSString *platformName = UMShareToSina;
    
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
    {
        NSLog(@"login response is %@",response);
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
            NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
        }
    });

}

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.viewControllerType == UMSViewControllerOauth) {
        NSLog(@"didFinishOauthAndGetAccount response is %@",response);
    }
}



@end
