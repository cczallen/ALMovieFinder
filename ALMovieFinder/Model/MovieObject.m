//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "MovieObject.h"

@implementation MovieObject


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.rating  = [json objectForKey:@"rating"];
 self.id  = [json objectForKey:@"id"];
 self.sources  = [[SourcesEntity alloc] initWithJson:[json objectForKey:@"sources"]];
 self.trailer  = [[TrailerEntity alloc] initWithJson:[json objectForKey:@"trailer"]];
 self.runtime  = [json objectForKey:@"runtime"];
 self.title  = [json objectForKey:@"title"];
 self.backdrop  = [[BackdropEntity alloc] initWithJson:[json objectForKey:@"backdrop"]];
 self.plot  = [json objectForKey:@"plot"];
 self.language  = [json objectForKey:@"language"];
 self.year  = [json objectForKey:@"year"];
 self.imdb_code  = [json objectForKey:@"imdb_code"];
 self.tmdb_code  = [json objectForKey:@"tmdb_code"];
 self.poster  = [[PosterEntity alloc] initWithJson:[json objectForKey:@"poster"]];
 self.available_languages = [NSMutableArray array];
for(NSDictionary *item in [json objectForKey:@"available_languages"])
{
[self.available_languages addObject:[[Available_languagesEntity alloc] initWithJson:item]];
}

    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.rating forKey:@"zx_rating"];
[aCoder encodeObject:self.id forKey:@"zx_id"];
[aCoder encodeObject:self.sources forKey:@"zx_sources"];
[aCoder encodeObject:self.trailer forKey:@"zx_trailer"];
[aCoder encodeObject:self.runtime forKey:@"zx_runtime"];
[aCoder encodeObject:self.title forKey:@"zx_title"];
[aCoder encodeObject:self.backdrop forKey:@"zx_backdrop"];
[aCoder encodeObject:self.plot forKey:@"zx_plot"];
[aCoder encodeObject:self.language forKey:@"zx_language"];
[aCoder encodeObject:self.year forKey:@"zx_year"];
[aCoder encodeObject:self.imdb_code forKey:@"zx_imdb_code"];
[aCoder encodeObject:self.tmdb_code forKey:@"zx_tmdb_code"];
[aCoder encodeObject:self.poster forKey:@"zx_poster"];
[aCoder encodeObject:self.available_languages forKey:@"zx_available_languages"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.rating = [aDecoder decodeObjectForKey:@"zx_rating"];
 self.id = [aDecoder decodeObjectForKey:@"zx_id"];
 self.sources = [aDecoder decodeObjectForKey:@"zx_sources"];
 self.trailer = [aDecoder decodeObjectForKey:@"zx_trailer"];
 self.runtime = [aDecoder decodeObjectForKey:@"zx_runtime"];
 self.title = [aDecoder decodeObjectForKey:@"zx_title"];
 self.backdrop = [aDecoder decodeObjectForKey:@"zx_backdrop"];
 self.plot = [aDecoder decodeObjectForKey:@"zx_plot"];
 self.language = [aDecoder decodeObjectForKey:@"zx_language"];
 self.year = [aDecoder decodeObjectForKey:@"zx_year"];
 self.imdb_code = [aDecoder decodeObjectForKey:@"zx_imdb_code"];
 self.tmdb_code = [aDecoder decodeObjectForKey:@"zx_tmdb_code"];
 self.poster = [aDecoder decodeObjectForKey:@"zx_poster"];
 self.available_languages = [aDecoder decodeObjectForKey:@"zx_available_languages"];
 
    }
    return self;
}



@end
