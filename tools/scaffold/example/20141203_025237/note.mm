//    												
//    												
//    	 ______    ______    ______					
//    	/\  __ \  /\  ___\  /\  ___\			
//    	\ \  __<  \ \  __\_ \ \  __\_		
//    	 \ \_____\ \ \_____\ \ \_____\		
//    	  \/_____/  \/_____/  \/_____/			
//    												
//    												
//    												
// title:  Note
// author: jebai
// date:   2014-12-03 06:52:37 +0000
//

#import "note.h"

#pragma mark - Note

@implementation Note

@synthesize content = _content;
@synthesize created_at = _created_at;
@synthesize title = _title;
@synthesize id = _id;

- (BOOL)validate
{
	if ( nil == self.id || NO == [self.id isKindOfClass:[NSNumber class]] )
	{
		return NO;
	}

	return YES;
}

@end

#pragma mark - GET /notes

#pragma mark - REQ_NOTES

@implementation REQ_NOTES

@synthesize page = _page;
@synthesize per_page = _per_page;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_NOTES

@implementation RESP_NOTES

@synthesize notes = _notes;
@synthesize page = _page;
@synthesize pages = _pages;
@synthesize per_page = _per_page;
@synthesize total = _total;

CONVERT_PROPERTY_CLASS( notes, Note );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_NOTES

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_NOTES alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/notes"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_NOTES objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /notes/:id


@implementation API_NOTES_ID

@synthesize id = _id;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( NULL == self.id )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/notes/:id"];
		requestURI = [requestURI stringByReplacingOccurrencesOfString:@":id" withString:self.id];

		self.HTTP_GET( requestURI );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[Note class]] )
		{
			self.resp = (Note *)result;
		}
		else if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [Note objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - config

@implementation ServerConfig

DEF_SINGLETON( ServerConfig )

DEF_INT( CONFIG_DEVELOPMENT,	0 )
DEF_INT( CONFIG_TEST,			1 )
DEF_INT( CONFIG_PRODUCTION,	2 )

@synthesize config = _config;
@dynamic url;
@dynamic testUrl;
@dynamic productionUrl;
@dynamic developmentUrl;

- (NSString *)url
{
	NSString * host = nil;

	if ( self.CONFIG_DEVELOPMENT == self.config )
	{
		host = self.developmentUrl;
	}
	else if ( self.CONFIG_TEST == self.config )
	{
		host = self.testUrl;
	}
	else
	{
		host = self.productionUrl;
	}

	if ( NO == [host hasPrefix:@"http://"] && NO == [host hasPrefix:@"https://"] )
	{
		host = [@"http://" stringByAppendingString:host];
	}

	return host;
}

- (NSString *)developmentUrl
{
	return @"api.dribbble.com";
}

- (NSString *)testUrl
{
	return @"api.dribbble.com";
}

- (NSString *)productionUrl
{
	return @"api.dribbble.com";
}

@end

