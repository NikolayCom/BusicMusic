import Core
import UseCases

// MARK: - ArtistInfoInputInterface

public protocol ArtistInfoInputInterface: BaseInputInterface {}

// MARK: - ArtistInfoOutputInterface

public protocol ArtistInfoOutputInterface: BaseOutputInterface {}

// MARK: - ArtistInfoDependency

public typealias ArtistInfoDependency = HasPlayerUseCase

// MARK: - ArtistInfoConfigModel

public final class ArtistInfoConfigModel: BaseConfigModel<
    ArtistInfoInputInterface,
    ArtistInfoOutputInterface,
    ArtistInfoDependency
> {}
