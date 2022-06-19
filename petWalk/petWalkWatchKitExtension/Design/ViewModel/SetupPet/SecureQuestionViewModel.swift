//
//  SecureQuestionViewModel.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 11/6/22.
//

import Foundation

@MainActor
class SecureQuestionViewModel: ObservableObject {
    @Published var hasPetName: Bool = false
    var savePetNameUseCase: SavePetNameUseCase
    
    init(savePetNameUseCase: SavePetNameUseCase) {
        self.savePetNameUseCase = savePetNameUseCase
    }
    
    func savePetName(_ name: String) {
        savePetNameUseCase.execute(name)
    }
}
