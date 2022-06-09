//
//  SecureQuestionView.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 9/6/22.
//

import SwiftUI

struct SecureQuestionView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var hasPetName: Bool
    let cancelButtonText = "Cancel"
    let acceptButtonText = "Accept"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Are you sure?")
                .padding()
            
            HStack(spacing: 20) {
                Button {
                    dismiss()
                } label: {
                    Text(cancelButtonText)
                        .foregroundColor(.red)
                }
                .buttonStyle(.borderless)
                .padding()
                
                Button {
                    hasPetName = true
                    dismiss()
                } label: {
                    Text(acceptButtonText)
                        .foregroundColor(.blue)
                }
                .buttonStyle(.borderless)
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

struct SecureQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SecureQuestionView(hasPetName: .constant(false))
    }
}
