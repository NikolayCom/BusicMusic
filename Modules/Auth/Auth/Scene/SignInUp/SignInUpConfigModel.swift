import Core
import UseCases

// MARK: - SignInUpInputInterface

protocol SignInUpInputInterface: BaseInputInterface {}

// MARK: - SignInUpOutputInterface

protocol SignInUpOutputInterface: BaseOutputInterface {
    func showEmailScreen()
    func showInDeveloping()
}

// MARK: - SignInUpDependency

typealias SignInUpDependency = HasAuthUseCase

// MARK: - SignInUpConfigModel

final class SignInUpConfigModel: BaseConfigModel<
    SignInUpInputInterface,
    SignInUpOutputInterface,
    SignInUpDependency
> {
    let screenType: SignInUpViewModel.ScreenType

    init(
        screenType: SignInUpViewModel.ScreenType,
        output: SignInUpOutputInterface?,
        dependency: SignInUpDependency
    ) {
        self.screenType = screenType

        super.init(output: output, dependency: dependency)
    }
}
