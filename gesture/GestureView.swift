//
//  GestureView.swift
//  gesture
//
//  Created by Lin Hess on 2021/10/15.
//

import SwiftUI


struct GestureDetect: View {
    
 //  @Published  var igesture:String = "Nil"
    // 1.
    @GestureState  var translation = CGFloat(1.0)
    @State private var degrees: Double = 0
    @State private var scale: CGFloat = 1.0
    @State private var steping: CGFloat = -0.1
    @State var offset = CGPoint.zero
    @State var dragmoves:Int = 1
    @State var position = CGPoint.zero

    var body: some View {
        // 2.
        let magnificationGesture = MagnificationGesture().onChanged { (value) in
            self.scale = value.magnitude
        }
        // 3.
        let rotationGesture = RotationGesture().onChanged { (value) in
            self.degrees = value.degrees
        }
       let magnificationAndRotateGesture = magnificationGesture.simultaneously(with: rotationGesture)
      //  let magnificationAndRotateGestureAnddraggesture = draggesture.simultaneously(with: magnificationAndRotateGesture)
 
        let tapgesture = TapGesture()
                            .onEnded { _ in
                                if (self.dragmoves == 2){
                                    self.dragmoves = 1
                                    return
                                }
                                self.scale  += self.steping
                            if  abs(self.scale - 0.3) < 0.0001 {
                                self.steping = 0.1
                            }else if abs(self.scale - 1.7) < 0.0001 {
                                self.steping = -0.1
                            }
                            print("tap  position \(self.position)")
                        }
        let draggesture = DragGesture(minimumDistance: 0, coordinateSpace: .global)
      /*  .updating(self.$translation){
            value, state, _  in
            self.offset.x  = value.location.x - value.startLocation.x
            self.offset.y  = value.location.y - value.startLocation.y
            self.position = value.location
            print("drag startpos1\(value.startLocation)")
            print("drag position1\(value.location)")
        }*/.onChanged{ value in
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

       Image("stone")
            .scaleEffect(scale)
            .gesture(draggesture)
            .gesture(magnificationAndRotateGesture)
           .rotationEffect(Angle(degrees: degrees))
            .offset(x:offset.x,y:offset.y)
            .animation(.easeInOut)
    }
        
}

