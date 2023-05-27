import Foundation

public protocol UserDefaultsRepository: AutoMockable {
    func getAccumulatedDailySteps() -> Int
    func saveAccumulatedDailySteps(_ steps: Int)
    
    func getTotalSteps() -> Int
    func saveTotalSteps(_ steps: Int)
    
    func getDateDailySteps() -> Date
    func saveDateDailySteps(_ date: Date)
    
    func getPreviousAnimationProgress() -> Double
    func savePreviousAnimationProgress(_ previousAnimationProgress: Double)
    
    func getPetName() -> String
    func savePetName(_ name: String)
    
    func getPetLevel() -> Int
    func savePetLevel(_ level: Int)
    
    func getPetRol() -> String
    func savePetRol(_ rol: String)
    
    func saveTrackingDailySteps(_ permission: Bool)
}
