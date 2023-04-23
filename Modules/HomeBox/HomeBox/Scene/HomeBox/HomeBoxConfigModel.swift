import Core
import UseCases

// MARK: - HomeBoxWidgets
enum HomeBoxWidget: CaseIterable, Equatable {
    case shazam
    case myLibrary
}

// MARK: - HomeBoxInputInterface

public protocol HomeBoxInputInterface: BaseInputInterface {}

// MARK: - DefaultOutputInterface

public protocol HomeBoxOutputInterface: BaseOutputInterface {}

// MARK: - DefaultDependency

public typealias HomeBoxDependency = HasAuthUseCase

// MARK: - DefaultConfigModel

public final class HomeBoxConfigModel: BaseConfigModel<
    HomeBoxInputInterface,
    HomeBoxOutputInterface,
    HomeBoxDependency
> {}
