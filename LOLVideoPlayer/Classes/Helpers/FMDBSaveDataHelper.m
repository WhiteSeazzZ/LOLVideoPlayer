//
//  FMDBSaveDataHelper.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/9.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "FMDBSaveDataHelper.h"

@implementation FMDBSaveDataHelper

+ (void)FMDBSaveDataHelperWithData:(id)responseObj andName:(NSString *)nameString{
    FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
    if ([db open]) {
        [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
        
        FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = ?",nameString];
        NSData *data = [NSData data];
        while ([resultSet next]) {
            data = [resultSet dataForColumn:@"data"];
        }
        if (data.bytes == 0) {
            [db executeUpdate:@"insert into videoPlayer (data,name) values (?,?)",responseObj,nameString];
        }else{
            [db executeUpdate:@"update videoPlayer set data = ? where name = ?",responseObj,nameString];
        }
        [db close];
    }
}

@end
