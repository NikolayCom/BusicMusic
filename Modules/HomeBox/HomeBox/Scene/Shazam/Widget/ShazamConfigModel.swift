import Core
import UseCases

// MARK: - ShazamBoxInputInterface

public protocol ShazamInputInterface: BaseInputInterface {}

// MARK: - ShazamOutputInterface

public protocol ShazamOutputInterface: BaseOutputInterface {
    func showShazamView()
}

// MARK: - ShazamDependency

public typealias ShazamDependency = HasAuthUseCase

// MARK: - ShazamConfigModel

public final class ShazamConfigModel: BaseConfigModel<
    ShazamInputInterface,
    ShazamOutputInterface,
    ShazamDependency
> {}
