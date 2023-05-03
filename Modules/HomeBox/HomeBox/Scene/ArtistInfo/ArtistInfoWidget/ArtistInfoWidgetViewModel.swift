import Core

// MARK: - ArtistInfoWidgetViewModelInterface

public protocol ArtistInfoWidgetViewModelInterface: BaseViewModelInterface {
    func actionButtonTapped()
}

// MARK: - InDevelopingViewModel

public final class ArtistInfoWidgetViewModel: BaseViewModel<
    ArtistInfoWidgetViewControllerInterface,
    ArtistInfoWidgetViewInterface,
    ArtistInfoWidgetConfigModel
> {
    public override func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - ArtistInfoWidgetViewModel

extension ArtistInfoWidgetViewModel: ArtistInfoWidgetViewModelInterface {
    public func actionButtonTapped() {
        self.config.output?.showArtistInfo()
    }
}

// MARK: - ArtistInfoWidgetViewModel

extension ArtistInfoWidgetViewModel: ArtistInfoWidgetInputInterface {}
