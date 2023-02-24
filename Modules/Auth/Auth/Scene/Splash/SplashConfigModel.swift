import Core
import UseCases

// MARK: - SplashInputInterface

protocol SplashInputInterface: BaseInputInterface {}

// MARK: - SplashOutputInterface

protocol SplashOutputInterface: BaseOutputInterface {}

// MARK: - SplashDependency

typealias SplashDependency = HasAuthUseCase

// MARK: - SplashConfigModel

final class SplashConfigModel: BaseConfigModel<
    SplashInputInterface, SplashOutputInterface, SplashDependency
> {}
