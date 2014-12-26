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

#import "Bee.h"

#pragma mark - models

@class Note;

@interface Note : BeeActiveObject
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			created_at;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSNumber *			id;
@end

#pragma mark - controllers

#pragma mark - GET /notes
@interface REQ_NOTES : BeeActiveObject
@property (nonatomic, retain) NSNumber *			page;
@property (nonatomic, retain) NSNumber *			per_page;
@end

@interface RESP_NOTES : BeeActiveObject
@property (nonatomic, retain) NSArray *				notes;
@property (nonatomic, retain) NSNumber *			page;
@property (nonatomic, retain) NSNumber *			pages;
@property (nonatomic, retain) NSNumber *			per_page;
@property (nonatomic, retain) NSNumber *			total;
@end


@interface API_NOTES : BeeAPI
@property (nonatomic, retain) REQ_NOTES *	req;
@property (nonatomic, retain) RESP_NOTES *	resp;
@end

#pragma mark - GET /notes/:id


@interface API_NOTES_ID : BeeAPI
@property (nonatomic, retain) NSString *	id;
@property (nonatomic, retain) Note *	resp;
@end

#pragma mark - config

@interface ServerConfig : NSObject

AS_SINGLETON( ServerConfig )

AS_INT( CONFIG_DEVELOPMENT )
AS_INT( CONFIG_TEST )
AS_INT( CONFIG_PRODUCTION )

@property (nonatomic, assign) NSUInteger			config;

@property (nonatomic, readonly) NSString *			url;
@property (nonatomic, readonly) NSString *			testUrl;
@property (nonatomic, readonly) NSString *			productionUrl;
@property (nonatomic, readonly) NSString *			developmentUrl;

@end

