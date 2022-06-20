//
//  SecureQuestionView.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 9/6/22.
//

import SwiftUI

struct SecureQuestionView: View {
    private let cancelButtonText = "Cancel"
    private let acceptButtonText = "Accept"
    
    @Environment(\.dismiss) var dismiss
    @StateObject var secureQuestionViewModel: SecureQuestionViewModel
    
    @Binding var hasPetName: Bool
    @Binding var petName: String
    
    init(hasPetName: Binding<Bool>, petName: Binding<String>, viewModel: SecureQuestionViewModel) {
        _secureQuestionViewModel = StateObject(wrappedValue: viewModel)
        _hasPetName = hasPetName
        _petName = petName
    }
    
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
                    secureQuestionViewModel.savePetName(petName)
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
        SecureQuestionViewFactory().make(hasPetName: .constant(true), petName: .constant("Beldrick"))
    }
}
