//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器   http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NetflixEntity : NSObject<NSCoding>

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *netflix_code;
 


-(id)initWithJson:(NSDictionary *)json;

@end
