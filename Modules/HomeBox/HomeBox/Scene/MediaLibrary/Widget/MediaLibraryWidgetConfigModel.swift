import Core
import UseCases

// MARK: - MediaLibraryWidgetInputInterface

public protocol MediaLibraryWidgetInputInterface: BaseInputInterface {}

// MARK: - MediaLibraryWidgetOutputInterface

public protocol MediaLibraryWidgetOutputInterface: BaseOutputInterface {
    func showLibrary()
}

// MARK: - MediaLibraryWidgetDependency

public typealias MediaLibraryWidgetDependency = HasAuthUseCase

// MARK: - MediaLibraryWidgetConfigModel

public final class MediaLibraryWidgetConfigModel: BaseConfigModel<
    MediaLibraryWidgetInputInterface,
    MediaLibraryWidgetOutputInterface,
    MediaLibraryWidgetDependency
> {}
