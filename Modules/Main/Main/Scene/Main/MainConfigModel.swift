import Core
import UseCases

// MARK: - MainInputInterface

public protocol MainInputInterface: BaseInputInterface {}

// MARK: - MainOutputInterface

public protocol MainOutputInterface: BaseOutputInterface {}

// MARK: - MainDependency

public typealias MainDependency = HasAuthUseCase

// MARK: - MainConfigModel

public final class MainConfigModel: BaseConfigModel<
    MainInputInterface,
    MainOutputInterface,
    MainDependency
> {}
