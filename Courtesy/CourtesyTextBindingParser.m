//
//  CourtesyTextBindingParser.m
//  Courtesy
//
//  Created by Zheng on 3/1/16.
//  Copyright © 2016 82Flex. All rights reserved.
//

#import "CourtesyTextBindingParser.h"

@interface CourtesyTextBindingParser ()
@property (nonatomic, strong) NSRegularExpression *regex_email;
@property (nonatomic, strong) NSRegularExpression *regex_url;
@property (nonatomic, strong) NSRegularExpression *regex_at;
@end

@implementation CourtesyTextBindingParser

- (instancetype)init {
    self = [super init];
    NSString *pattern_email = @"[a-zA-Z0-9.\\-_]{2,32}@[a-zA-Z0-9.\\-_]{2,32}\\.[A-Za-z]{2,4}\\s+";
    NSString *pattern_url = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?\\s+";
    NSString *pattern_at = @"[^a-zA-Z0-9.\\-_]+@[a-zA-Z0-9.\\-_]{2,32}\\s+";
    self.regex_email = [[NSRegularExpression alloc] initWithPattern:pattern_email options:kNilOptions error:nil];
    self.regex_url = [[NSRegularExpression alloc] initWithPattern:pattern_url options:kNilOptions error:nil];
    self.regex_at = [[NSRegularExpression alloc] initWithPattern:pattern_at options:kNilOptions error:nil];
    return self;
}

- (BOOL)parseText:(NSMutableAttributedString *)text selectedRange:(NSRangePointer)range {
    __block BOOL changed = NO;
    void (^handler) (NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) = ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        if (!result) return;
        NSRange range = result.range;
        if (range.location == NSNotFound || range.length < 1) return;
        if ([text attribute:YYTextBindingAttributeName atIndex:range.location effectiveRange:NULL]) return;
        
        NSRange bindlingRange = NSMakeRange(range.location, range.length);
        YYTextBinding *binding = [YYTextBinding bindingWithDeleteConfirm:YES];
        [text setTextBinding:binding range:bindlingRange]; /// Text binding
        [text setColor:[UIColor blueberryColor] range:NSMakeRange(bindlingRange.location, bindlingRange.length - 1)];
        changed = YES;
    };
    [_regex_email enumerateMatchesInString:text.string options:NSMatchingWithoutAnchoringBounds range:text.rangeOfAll usingBlock:handler];
    [_regex_url enumerateMatchesInString:text.string options:NSMatchingWithoutAnchoringBounds range:text.rangeOfAll usingBlock:handler];
    [_regex_at enumerateMatchesInString:text.string options:NSMatchingWithoutAnchoringBounds range:text.rangeOfAll usingBlock:handler];
    return changed;
}

@end
