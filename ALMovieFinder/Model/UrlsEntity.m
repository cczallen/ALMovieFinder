//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "UrlsEntity.h"

@implementation UrlsEntity


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.w342  = [json objectForKey:@"w342"];
 self.original  = [json objectForKey:@"original"];
 self.w185  = [json objectForKey:@"w185"];
 self.w154  = [json objectForKey:@"w154"];
 self.w500  = [json objectForKey:@"w500"];
 self.w92  = [json objectForKey:@"w92"];
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.w342 forKey:@"zx_w342"];
[aCoder encodeObject:self.original forKey:@"zx_original"];
[aCoder encodeObject:self.w185 forKey:@"zx_w185"];
[aCoder encodeObject:self.w154 forKey:@"zx_w154"];
[aCoder encodeObject:self.w500 forKey:@"zx_w500"];
[aCoder encodeObject:self.w92 forKey:@"zx_w92"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.w342 = [aDecoder decodeObjectForKey:@"zx_w342"];
 self.original = [aDecoder decodeObjectForKey:@"zx_original"];
 self.w185 = [aDecoder decodeObjectForKey:@"zx_w185"];
 self.w154 = [aDecoder decodeObjectForKey:@"zx_w154"];
 self.w500 = [aDecoder decodeObjectForKey:@"zx_w500"];
 self.w92 = [aDecoder decodeObjectForKey:@"zx_w92"];
 
    }
    return self;
}



@end
