//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器   http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NetflixEntity.h"

@interface SourcesEntity : NSObject<NSCoding>

@property (nonatomic,strong) NetflixEntity *netflix;
 


-(id)initWithJson:(NSDictionary *)json;

@end
