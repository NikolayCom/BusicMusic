import Core
import UIComponents
import Models

private enum Constants {
    static var requestTime: Double { 2 }
}

// MARK: - ArtistInfoViewModelInterface

public protocol ArtistInfoViewModelInterface: BaseViewModelInterface {
    var collectionData: [CollectionData] { get }

    func textDidChange(text: String)
}

// MARK: - ArtistInfoViewModel

public final class ArtistInfoViewModel: BaseViewModel<
    ArtistInfoViewControllerInterface,
    ArtistInfoViewInterface,
    ArtistInfoConfigModel
> {
    public var collectionData: [CollectionData] = []

    private var searchingTimer: Timer?

    private var searchText: String = "" {
        willSet {
            searchingTimer?.invalidate()
            guard !newValue.isEmpty else { return }
            startTimer()
        }
    }

    override public func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - Private

private extension ArtistInfoViewModel {
    func startTimer() {
        self.searchingTimer = Timer.scheduledTimer(
            withTimeInterval: Constants.requestTime,
            repeats: false
        ) { [weak self] _ in
            self?.getArtists()
        }
    }

    func setupCollection(with artists: [Artist]) {
        self.collectionData = [
            CollectionData(
                section: nil,
                rows: artists.sorted(by: { $0.score > $1.score }).map { artist in
                    ArtistInfoCollectionViewModel(
                        id: artist.id,
                        score: artist.score,
                        type: artist.type,
                        name: artist.name,
                        gender: artist.gender,
                        country: artist.country,
                        disambiguation: artist.disambiguation
                    )
                }
            )
        ]

        self.view.reloadData()
    }

    func getArtists() {
        self.controller.showHud()
        self.config.dependency?.playerUseCase.getArtists(name: self.searchText) { [weak self] result in
            self?.controller.hideHud()
            switch result {
            case .value(let artists):
                self?.setupCollection(with: artists)

            case .error(let error):
                self?.controller.showErrorBanner(with: error.message.orEmpty)
            }
        }
    }
}

// MARK: - ArtistInfoViewModel

extension ArtistInfoViewModel: ArtistInfoViewModelInterface {
    public func textDidChange(text: String) {
        self.searchText = text
    }
}

// MARK: - ArtistInfoViewModel

extension ArtistInfoViewModel: ArtistInfoInputInterface {}
