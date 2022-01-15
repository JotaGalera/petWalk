//
//  petAnimationScene.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 8/1/22.
//

import SwiftUI

struct petAnimationScene: View {
    @State private var count = 0
    private let width: CGFloat = 70
    private let height: CGFloat = 70
    var pet: Pets

    var body: some View {
        VStack {
            Text(pet.name)
                .bold()
            
            Spacer().frame(height: 25)
            
            Image(pet.images[count])
                .resizable()
                .frame(width: width,
                       height: height,
                       alignment: .center)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 0.1,
                                         repeats: true) { timer in
                        withAnimation() {
                            self.count = count == 7 ? 0 : count + 1
                        }
                    }
                }
        }
    }
}
struct petAnimationScene_Previews: PreviewProvider {
    static var previews: some View {
        petAnimationScene(pet: Swordman(name: "Beldrick"))
    }
}
