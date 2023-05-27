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
    @Binding var petName: String
    @Binding var isRolSelected: Bool
    
    init(petName: Binding<String>, viewModel: SecureQuestionViewModel, isRolSelected: Binding<Bool>) {
        _secureQuestionViewModel = StateObject(wrappedValue: viewModel)
        _petName = petName
        _isRolSelected = isRolSelected
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Are you sure?")
                .padding()
            
            HStack(spacing: 20) {
                Button {
                    isRolSelected = false
                    secureQuestionViewModel.removePetRol()
                    dismiss()
                } label: {
                    Text(cancelButtonText)
                        .foregroundColor(.red)
                }
                .buttonStyle(.borderless)
                .padding()
                
                Button {
                    secureQuestionViewModel.savePetName(petName)
                    dismiss()
                } label: {
                    Text(acceptButtonText)
                        .foregroundColor(.blue)
                }
                .buttonStyle(.borderless)
                .padding()
            }
        }
    }
}

struct SecureQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SecureQuestionViewFactory().make(petName: .constant("Beldrick"), isRolSelected: .constant(true))
    }
}
