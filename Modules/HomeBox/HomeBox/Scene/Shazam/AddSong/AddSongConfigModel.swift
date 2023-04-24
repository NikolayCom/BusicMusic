import Core
import UseCases

// MARK: - AddSongInputInterface

public protocol AddSongInputInterface: BaseInputInterface {}

// MARK: - AddSongOutputInterface

public protocol AddSongOutputInterface: BaseOutputInterface {
    func dismissScreen()
}

// MARK: - AddSongDependency

public typealias AddSongDependency = HasShazamUseCase

// MARK: - AddSongConfigModel

public final class AddSongConfigModel: BaseConfigModel<
    AddSongInputInterface,
    AddSongOutputInterface,
    AddSongDependency
> {}
