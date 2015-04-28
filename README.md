FLToasty
==================================

Show inapp notifications for users with not annoying manner. This notification will dismiss automatically after delay. Also you could provide tap behavior for them.

![ToasyDemo](https://raw.githubusercontent.com/devenergy/FLToasty/master/toasty_demo.gif)

How to use
==================================

Add to your Podfile

`pod 'FLToasty', :git => 'https://github.com/devenergy/FLToasty'`

Import and type something like this.

```
[FLToasty showInfo:NSLocalizedString(@"toast_share_later", @"Popup toast says You can share later") inView:self.view];
```

or add tap handling if you need it.

```
[FLToasty showInfo:NSLocalizedString(@"toast_delete_card_undo", @"Popup toast says UNDO when delete card") 
          inView:self.view 
          didTapBlock:^{
                [self.model undoRoomDeletion:r.identifier];
              }];
```

Control toast look with appearance proxy.

```
[FLToasty appearance].font = [UIFont fontWithName:@"FiraSans-Regular" size:14.0f];
```

That's all! Well done!

