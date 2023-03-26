import Core
import UseCases
import Models

// MARK: - EmailInputInterface

public protocol EmailInputInterface: BaseInputInterface {}

// MARK: - EmailOutputInterface

public protocol EmailOutputInterface: BaseOutputInterface {
    func showMain()
}

// MARK: - EmailDependency

public typealias EmailDependency = HasAuthUseCase

// MARK: - EmailConfigModel

public final class EmailConfigModel: BaseConfigModel<
    EmailInputInterface,
    EmailOutputInterface,
    EmailDependency
> {
    let screenType: AuthScreenType

    init(
        screenType: AuthScreenType,
        output: EmailOutputInterface?,
        dependency: EmailDependency
    ) {
        self.screenType = screenType

        super.init(output: output, dependency: dependency)
    }
}
