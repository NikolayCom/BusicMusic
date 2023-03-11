import Core
import UseCases

// MARK: - OnBoardingInputInterface

protocol OnBoardingInputInterface: BaseInputInterface {}

// MARK: - OnBoardingOutputInterface

protocol OnBoardingOutputInterface: BaseOutputInterface {
    func actionButtonTapped(with screenType: SignInUpViewModel.ScreenType)
}

// MARK: - OnBoardingDependency

typealias OnBoardingDependency = HasAuthUseCase

// MARK: - OnBoardingConfigModel

final class OnBoardingConfigModel: BaseConfigModel<
    OnBoardingInputInterface,
    OnBoardingOutputInterface,
    OnBoardingDependency
> {}
