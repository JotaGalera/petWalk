import Foundation

protocol SaveDailyStepsUseCase: AutoMockable {
    func execute(_ steps: Int)
}

class SaveDailyStepsUseCaseImplementation: SaveDailyStepsUseCase {
    private var repository: UserDefaultsRepository
    
    public init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute(_ steps: Int) {
        repository.saveDailySteps(steps)
    }
}
