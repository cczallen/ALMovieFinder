//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "BackdropEntity.h"

@implementation BackdropEntity


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.urls  = [[UrlsEntity alloc] initWithJson:[json objectForKey:@"urls"]];
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.urls forKey:@"zx_urls"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.urls = [aDecoder decodeObjectForKey:@"zx_urls"];
 
    }
    return self;
}



@end
