import Core
import UseCases

// MARK: - MediaLibraryInputInterface

public protocol MediaLibraryInputInterface: BaseInputInterface {}

// MARK: - MediaLibraryOutputInterface

public protocol MediaLibraryOutputInterface: BaseOutputInterface {}

// MARK: - MediaLibraryDependency

public typealias MediaLibraryDependency = HasAuthUseCase

// MARK: - MediaLibraryConfigModel

public final class MediaLibraryConfigModel: BaseConfigModel<
    MediaLibraryInputInterface,
        MediaLibraryOutputInterface,
MediaLibraryDependency
> {}
