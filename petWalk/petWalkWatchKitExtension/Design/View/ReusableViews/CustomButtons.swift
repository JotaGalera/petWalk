//
//  CustomButtons.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 20/8/22.
//

import Foundation
import SwiftUI

struct ContinueButton: View {
    var action: () -> Void
    var text = "Continue"
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(.blue)
        }
        .buttonStyle(.borderless)
        .padding()
    }
}

struct ArrowButton: View {
    var action: () -> Void
    var imageName: String
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 25, height: 25)
        }
        .buttonStyle(.borderless)
    }
}

struct ContinueButton_Preview: PreviewProvider {
    static var previews: some View {
        ContinueButton {
            // Intentional blank
        }
    }
}

struct ArrowButton_Preview: PreviewProvider {
    static var previews: some View {
        ArrowButton(action: {
            // Intentional blank
        }, imageName: "arrowtriangle.left.circle.fill")
    }
}
