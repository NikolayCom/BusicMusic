import Core
import UseCases

// MARK: - InDevelopingInputInterface

public protocol InDevelopingInputInterface: BaseInputInterface {}

// MARK: - InDevelopingOutputInterface

public protocol InDevelopingOutputInterface: BaseOutputInterface {}

// MARK: - InDevelopingDependency

public typealias InDevelopingDependency = HasAuthUseCase

// MARK: - InDevelopingConfigModel

public final class InDevelopingConfigModel: BaseConfigModel<
    InDevelopingInputInterface,
    InDevelopingOutputInterface,
    InDevelopingDependency
> {}
