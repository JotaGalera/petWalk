import Foundation

public protocol SaveAccumulatedDailyStepsUseCase: AutoMockable {
    func execute(_ steps: Int)
}

class SaveAccumulatedDailyStepsUseCaseImplementation: SaveAccumulatedDailyStepsUseCase {
    private var repository: UserDefaultsRepository
    
    public init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute(_ steps: Int) {
        repository.saveAccumulatedDailySteps(steps)
        repository.saveDateDailySteps(Date.now)
    }
}
