//
//  SourceEditorCommand.m
//  FWExtension
//
//  Created by kfw on 2019/9/12.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "SourceEditorCommand.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    if ([invocation.commandIdentifier isEqualToString:@"com.shendeng.zhineng.XcodeDemo.FWExtension.SourceEditorCommand"]) {
        XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
        NSInteger curIndex = selection.start.line;
        NSMutableArray *totalLines = invocation.buffer.lines;
        NSInteger totalLinesCount = totalLines.count;
//        NSString *curLineContent = totalLines[curIndex];
        
        for (int i = 0; i < totalLinesCount; i++) {
            NSString *lineContent = totalLines[i];
            if ([lineContent containsString:@"@interface"]) {
                
                NSString *selectLineContent = totalLines[curIndex];
                NSString *userSelectContent = [selectLineContent substringWithRange:NSMakeRange(selection.start.column, selection.end.column - 4)];
                NSString *insertContent = [NSString stringWithFormat:@"#import \"%@.h\"", userSelectContent];
                
                [totalLines insertObject:insertContent atIndex:i - 1];
                break;
            }
        }
    }
    
    completionHandler(nil);
}

@end
