//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "Available_languagesEntity.h"

@implementation Available_languagesEntity


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.name  = [json objectForKey:@"name"];
 self.code  = [json objectForKey:@"code"];
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"zx_name"];
[aCoder encodeObject:self.code forKey:@"zx_code"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.name = [aDecoder decodeObjectForKey:@"zx_name"];
 self.code = [aDecoder decodeObjectForKey:@"zx_code"];
 
    }
    return self;
}



@end
