import Foundation

protocol SaveDailyStepsUseCase {
    func saveDailySteps(_ steps: Int)
}

class SaveDailyStepsUseCaseImplementation: SaveDailyStepsUseCase {
    private var repository: UserDefaultRepository
    
    public init(repository: UserDefaultRepository) {
        self.repository = repository
    }
    
    func saveDailySteps(_ steps: Int) {
        repository.saveDailySteps(steps)
    }
}
