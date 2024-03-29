import Core
import UseCases

// MARK: - HomeBoxWidgets
enum HomeBoxWidget: CaseIterable, Equatable {
    case mediaLibrary
    case artistInfo
    case shazam
}

// MARK: - HomeBoxInputInterface

public protocol HomeBoxInputInterface: BaseInputInterface {}

// MARK: - DefaultOutputInterface

public protocol HomeBoxOutputInterface: BaseOutputInterface {
    func showProfile()
}

// MARK: - DefaultDependency

public typealias HomeBoxDependency = HasAuthUseCase

// MARK: - DefaultConfigModel

public final class HomeBoxConfigModel: BaseConfigModel<
    HomeBoxInputInterface,
    HomeBoxOutputInterface,
    HomeBoxDependency
> {}
