import Core
import UseCases

// MARK: - ShazamSearchInputInterface

public protocol ShazamSearchInputInterface: BaseInputInterface {}

// MARK: - ShazamSearchOutputInterface

public protocol ShazamSearchOutputInterface: BaseOutputInterface {
    func showAddSong()
}

// MARK: - ShazamSearchDependency

public typealias ShazamSearchDependency = HasShazamUseCase

// MARK: - ShazamSearchConfigModel

public final class ShazamSearchConfigModel: BaseConfigModel<
    ShazamSearchInputInterface,
    ShazamSearchOutputInterface,
    ShazamSearchDependency
> {}
