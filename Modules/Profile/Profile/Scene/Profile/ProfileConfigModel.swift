import Core
import UseCases

// MARK: - ProfileInputInterface

public protocol ProfileInputInterface: BaseInputInterface {}

// MARK: - ProfileOutputInterface

public protocol ProfileOutputInterface: BaseOutputInterface {
    func showSplash()
}

// MARK: - ProfileDependency

public typealias ProfileDependency = HasAuthUseCase

// MARK: - ProfileConfigModel

public final class ProfileConfigModel: BaseConfigModel<
    ProfileInputInterface,
    ProfileOutputInterface,
    ProfileDependency
> {}
