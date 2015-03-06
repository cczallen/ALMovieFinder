//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "SourcesEntity.h"

@implementation SourcesEntity


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.netflix  = [[NetflixEntity alloc] initWithJson:[json objectForKey:@"netflix"]];
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.netflix forKey:@"zx_netflix"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.netflix = [aDecoder decodeObjectForKey:@"zx_netflix"];
 
    }
    return self;
}



@end
