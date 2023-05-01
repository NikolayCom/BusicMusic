import Core
import UseCases

// MARK: - PlayerInputInterface

public protocol PlayerInputInterface: BaseInputInterface {}

// MARK: - PlayerOutputInterface

public protocol PlayerOutputInterface: BaseOutputInterface {}

// MARK: - PlayerDependency

public typealias PlayerDependency = HasPlayerUseCase

// MARK: - PlayerConfigModel

public final class PlayerConfigModel: BaseConfigModel<
    PlayerInputInterface,
    PlayerOutputInterface,
    PlayerDependency
> {}
