# gestures
SwiftUI for Multiple gestures 2021/10/16
Xcode 12, iOS 14.4
1. Draggesture has first priority, it records the tap position for TapGesture
2. two touchs is after Draggesture, otherwise the updating and onChange in Draggesture will not run. **Why?**


**TODO**
1. Image State parameter is not sync safety.
2. some  action is buggy. just check gesture work or not
3. Image Bounding with View Frame, It is need to checked.
