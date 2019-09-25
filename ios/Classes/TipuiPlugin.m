#import "TipuiPlugin.h"
#import <tipui/tipui-Swift.h>

@implementation TipuiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTipuiPlugin registerWithRegistrar:registrar];
}
@end
