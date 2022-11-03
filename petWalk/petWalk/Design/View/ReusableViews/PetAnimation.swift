//
//  PetAnimation.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 15/8/22.
//

import SwiftUI

struct PetAnimation: View {
    private let width: CGFloat = 70
    private let height: CGFloat = 70
    
    var petImages: [String]
    @State private var count = 0
    @State var timer: Timer? = nil
    
    var body: some View {
        Image(petImages[count])
            .resizable()
            .frame(width: width,
                   height: height,
                   alignment: .center)
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 0.1,
                                     repeats: true) { timer in
                    withAnimation() {
                        self.count = count == 7 ? 0 : count + 1
                    }
                }
            }
            .onDisappear {
                guard let timer = timer else { return }
                timer.invalidate()
            }
    }
}

struct PetAnimation_Preview: PreviewProvider {
    static var previews: some View {
        PetAnimation(petImages: ["run1",
                                 "run2",
                                 "run3",
                                 "run4",
                                 "run5",
                                 "run6",
                                 "run7",
                                 "run8"])
    }
}
