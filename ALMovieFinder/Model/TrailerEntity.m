//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "TrailerEntity.h"

@implementation TrailerEntity


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.url  = [json objectForKey:@"url"];
 self.provider  = [json objectForKey:@"provider"];
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.url forKey:@"zx_url"];
[aCoder encodeObject:self.provider forKey:@"zx_provider"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.url = [aDecoder decodeObjectForKey:@"zx_url"];
 self.provider = [aDecoder decodeObjectForKey:@"zx_provider"];
 
    }
    return self;
}



@end
