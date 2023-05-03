import Core
import UseCases

// MARK: - ArtistInfoWidgetInputInterface

public protocol ArtistInfoWidgetInputInterface: BaseInputInterface {}

// MARK: - ArtistInfoWidgetOutputInterface

public protocol ArtistInfoWidgetOutputInterface: BaseOutputInterface {
    func showArtistInfo()
}

// MARK: - ArtistInfoWidgetDependency

public typealias ArtistInfoWidgetDependency = HasAuthUseCase

// MARK: - ArtistInfoWidgetConfigModel

public final class ArtistInfoWidgetConfigModel: BaseConfigModel<
    ArtistInfoWidgetInputInterface,
    ArtistInfoWidgetOutputInterface,
    ArtistInfoWidgetDependency
> {}
