import Core
import UseCases
import Models

// MARK: - SignInUpInputInterface

protocol SignInUpInputInterface: BaseInputInterface {}

// MARK: - SignInUpOutputInterface

protocol SignInUpOutputInterface: BaseOutputInterface {
    func showEmailScreen(with screenType: AuthScreenType)
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
    let screenType: AuthScreenType

    init(
        screenType: AuthScreenType,
        output: SignInUpOutputInterface?,
        dependency: SignInUpDependency
    ) {
        self.screenType = screenType

        super.init(output: output, dependency: dependency)
    }
}
