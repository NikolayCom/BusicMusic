import Core
import UseCases

// MARK: - EmailInputInterface

protocol EmailInputInterface: BaseInputInterface {}

// MARK: - EmailOutputInterface

protocol EmailOutputInterface: BaseOutputInterface {}

// MARK: - EmailDependency

typealias EmailDependency = HasAuthUseCase

// MARK: - EmailConfigModel

final class EmailConfigModel: BaseConfigModel<
    EmailInputInterface,
    EmailOutputInterface,
    EmailDependency
> {}
