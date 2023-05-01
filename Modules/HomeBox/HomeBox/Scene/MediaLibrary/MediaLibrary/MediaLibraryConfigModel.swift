import Core
import UseCases

// MARK: - MediaLibraryInputInterface

public protocol MediaLibraryInputInterface: BaseInputInterface {}

// MARK: - MediaLibraryOutputInterface

public protocol MediaLibraryOutputInterface: BaseOutputInterface {
    func showPlayer()
}

// MARK: - MediaLibraryDependency

public typealias MediaLibraryDependency = HasAuthUseCase & HasPlayerUseCase

// MARK: - MediaLibraryConfigModel

public final class MediaLibraryConfigModel: BaseConfigModel<
    MediaLibraryInputInterface,
    MediaLibraryOutputInterface,
    MediaLibraryDependency
> {}
