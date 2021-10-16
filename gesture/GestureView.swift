//
//  GestureView.swift
//  gesture
//
//  Created by Spuggy0919 on 2021/10/15.
//

import SwiftUI


struct GestureDetect: View {
    
 //  @Published  var igesture:String = "Nil"
    // 1. Publish for outside use
    @GestureState  var translation = CGFloat(1.0)
    @State private var degrees: Double = 0
    @State private var scale: CGFloat = 1.0
    @State private var magnify: CGFloat = 1.0
    @State private var steping: CGFloat = -0.1
    @State var offset = CGPoint.zero
    @State var dragmoves:Int = 1
    @State var position = CGPoint.zero

    var body: some View {
        // 2. define your gesture , the sequence should be
        //     drag tap multitouch, otherwise the drag will not update and no onChange
        let magnificationGesture = MagnificationGesture().onChanged { (value) in
             
            self.magnify *= value.magnitude // modify from scale to magnify to sync with tap
            if (self.magnify<0.5){
                self.magnify=0.5
            }else if (self.magnify>2.0){
                self.magnify=2.0
            }
            print("magnify:\(value.magnitude)")
        }
        let rotationGesture = RotationGesture().onChanged { (value) in
        //    self.degrees = value.degrees
            /* TO DO need to bounding check */
           if (self.degrees < (-30)){
                self.degrees = -30
            }else if (self.degrees > 30){
                self.degrees = 30
            }
            print("degree:\(value.degrees)")
        }
       let magnificationAndRotateGesture = magnificationGesture.simultaneously(with: rotationGesture)
      //  let magnificationAndRotateGestureAnddraggesture = draggesture.simultaneously(with: magnificationAndRotateGesture)
        // zoom in out
        let tapgesture = TapGesture()
                            .onEnded { _ in
                                if (self.dragmoves == 2){
                                    self.dragmoves = 1
                                //    self.scale = 1.0
                                    return
                                }

                                self.scale  += self.steping
                            if  abs(self.scale - 0.5) < 0.0001 {
                                self.steping = 0.1
                            }else if abs(self.scale - 1.5) < 0.0001 {
                                self.steping = -0.1
                            }
                            print("tap  position \(self.position)")
                        }
        let draggesture = DragGesture(minimumDistance: 0, coordinateSpace: .global)
   /*    .updating(self.$translation){  // To do still not understand, study later
            value, state, _  in
            self.offset.x  += value.location.x - value.startLocation.x
            self.offset.y  += value.location.y - value.startLocation.y
            self.position = value.location
        }*/.onChanged{ value in
            /* TO DO need to bounding check */
            self.offset.x  = value.location.x - value.startLocation.x
            self.offset.y  = value.location.y - value.startLocation.y
            self.position = value.location
            print("drag startpos1\(value.startLocation)")
            print("drag position1\(value.location)")
        }.onEnded{value in
            self.offset.x  = value.location.x - value.startLocation.x
            self.offset.y  = value.location.y - value.startLocation.y
            self.position = value.location
                self.dragmoves = (abs(self.offset.x)<5 && abs(self.offset.y)<5.0) ? 1:2
                print("drag startpos \(value.startLocation)")
                print("drag position \(value.location)")
        } .sequenced(before: tapgesture)       // 4.
     //   let dragtap = draggesture.simultaneously(with: tapgesture)
        /* TODO state update unsafe */
       Image("stone")
            .scaleEffect(scale*magnify)
            .gesture(draggesture) // move to before magnify
            .gesture(magnificationAndRotateGesture)
            .rotationEffect(Angle(degrees: degrees))
            .offset(x:offset.x,y:offset.y)
            .animation(.easeInOut)
    }
        
}


