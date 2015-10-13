//
//  FA_InputAccessoryViewWebView.m
//  Pods
//
//  Created by Pierre Laurac on 9/29/15.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "FA_InputAccessoryWebView.h"

@interface FA_InputAccessoryWebView ()
    @property (nonatomic, assign) UIView * _accessoryView;
@end



@implementation FA_InputAccessoryWebView

static const char * const hackishFixClassName = "UIWebBrowserViewMinusAccessoryView";
static Class hackishFixClass = Nil;

- (UIView *)findBrowserView {
    UIScrollView *scrollView = self.scrollView;
    
    UIView *browserView = nil;
    for (UIView *subview in scrollView.subviews) {
        if ([NSStringFromClass([subview class]) hasPrefix:@"UIWebBrowserView"]) {
            browserView = subview;
            break;
        }
    }
    return browserView;
}

- (void)ensureHackishSubclassExistsOfBrowserViewClass:(Class)browserViewClass {
    // Checking if we already registered the new hacking class.
    if (!hackishFixClass) {
        Class newClass = objc_allocateClassPair(browserViewClass, hackishFixClassName, 0);
        objc_registerClassPair(newClass);
        hackishFixClass = newClass;
    }
    
    // Always replace the imp of the method.
    UIView * toolbar = self._accessoryView;
    id block = ^{
        return toolbar;
    };
    IMP blockImp = imp_implementationWithBlock(block);
    class_replaceMethod(hackishFixClass, @selector(inputAccessoryView), blockImp, "@@:");
}

- (void) changeAccessoryView:(UIView *)accessoryView {
    UIView *browserView = [self findBrowserView];
    if (browserView == nil) {
        return;
    }
    self._accessoryView = accessoryView;
    
    [self ensureHackishSubclassExistsOfBrowserViewClass:[browserView class]];
    
    object_setClass(browserView, hackishFixClass);
    [browserView reloadInputViews];
}

@end