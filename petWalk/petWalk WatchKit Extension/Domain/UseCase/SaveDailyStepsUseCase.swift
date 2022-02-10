import Foundation

protocol SaveDailyStepsUseCase {
    func execute(_ steps: Int)
}

class SaveDailyStepsUseCaseImplementation: SaveDailyStepsUseCase {
    private var repository: UserDefaultRepository
    
    public init(repository: UserDefaultRepository) {
        self.repository = repository
    }
    
    func execute(_ steps: Int) {
        repository.saveDailySteps(steps)
    }
}
