
typedef void (^SHNavigationControllerBlock)(UINavigationController * theNavigationController,
                                            UIViewController       * theViewController,
                                            BOOL                      isAnimated);


@interface UINavigationController (SHNavigationControllerBlocks)

#pragma mark -
#pragma mark Init
-(void)SH_setBlocks;


#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters

-(void)SH_setWillShowViewControllerBlock:(SHNavigationControllerBlock)theBlock;

-(void)SH_setDidShowViewControllerBlock:(SHNavigationControllerBlock)theBlock;

#pragma mark -
#pragma mark Getters

@property(nonatomic,readonly) SHNavigationControllerBlock SH_blockWillShowViewController;
@property(nonatomic,readonly) SHNavigationControllerBlock SH_blockDidShowViewController;
@end