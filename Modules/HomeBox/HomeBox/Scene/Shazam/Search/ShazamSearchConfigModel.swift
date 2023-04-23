import Core
import UseCases

// MARK: - ShazamSearchInputInterface

public protocol ShazamSearchInputInterface: BaseInputInterface {}

// MARK: - ShazamSearchOutputInterface

public protocol ShazamSearchOutputInterface: BaseOutputInterface {}

// MARK: - ShazamSearchDependency

public typealias ShazamSearchDependency = HasAuthUseCase

// MARK: - ShazamSearchConfigModel

public final class ShazamSearchConfigModel: BaseConfigModel<
    ShazamSearchInputInterface,
    ShazamSearchOutputInterface,
    ShazamSearchDependency
> {}
