//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器   http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SourcesEntity.h"
#import "TrailerEntity.h"
#import "BackdropEntity.h"
#import "PosterEntity.h"
#import "Available_languagesEntity.h"
#import <AFNetworking.h>

@interface MovieObject : NSObject<NSCoding>

@property (nonatomic,strong) NSString *rating;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) SourcesEntity *sources;
@property (nonatomic,strong) TrailerEntity *trailer;
@property (nonatomic,strong) NSNumber *runtime;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) BackdropEntity *backdrop;
@property (nonatomic,strong) NSString *plot;
@property (nonatomic,strong) NSString *language;
@property (nonatomic,strong) NSNumber *year;
@property (nonatomic,strong) NSString *imdb_code;
@property (nonatomic,strong) NSString *tmdb_code;
@property (nonatomic,strong) PosterEntity *poster;
@property (nonatomic,strong) NSMutableArray *available_languages;
 
+ (AFHTTPRequestOperation *)fetchMoviesByQueryString:(NSString *)queryString
                                             success:(void (^)(AFHTTPRequestOperation *operation, NSArray *movieObjects))success
                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(id)initWithJson:(NSDictionary *)json;

@end
