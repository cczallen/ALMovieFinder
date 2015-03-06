//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "NetflixEntity.h"

@implementation NetflixEntity


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.name  = [json objectForKey:@"name"];
 self.netflix_code  = [json objectForKey:@"netflix_code"];
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"zx_name"];
[aCoder encodeObject:self.netflix_code forKey:@"zx_netflix_code"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.name = [aDecoder decodeObjectForKey:@"zx_name"];
 self.netflix_code = [aDecoder decodeObjectForKey:@"zx_netflix_code"];
 
    }
    return self;
}



@end
