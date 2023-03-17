import Core
import UseCases
import Models

// MARK: - OnBoardingInputInterface

protocol OnBoardingInputInterface: BaseInputInterface {}

// MARK: - OnBoardingOutputInterface

protocol OnBoardingOutputInterface: BaseOutputInterface {
    func actionButtonTapped(with screenType: AuthScreenType)
}

// MARK: - OnBoardingDependency

typealias OnBoardingDependency = HasAuthUseCase

// MARK: - OnBoardingConfigModel

final class OnBoardingConfigModel: BaseConfigModel<
    OnBoardingInputInterface,
    OnBoardingOutputInterface,
    OnBoardingDependency
> {}
