# gesture
SwiftUI for Multiple gestures 2021/10/16
1. Draggesture has first priority, it record the tap position
2. two touchs is after Draggesture, otherwise the updating and onChange in Draggesture will not run. **Why?**
3. Action is not smoothly.
