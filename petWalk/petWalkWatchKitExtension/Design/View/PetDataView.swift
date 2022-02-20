//
//  PetDataView.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 20/2/22.
//

import SwiftUI

struct PetDataView: View {
    @State var dailySteps: Int
    
    var body: some View {
        HStack {
           Text("Exp: \(dailySteps)")
        }
    }
}

struct PetDataView_Previews: PreviewProvider {
    static var previews: some View {
        PetDataView(dailySteps: 10)
    }
}
