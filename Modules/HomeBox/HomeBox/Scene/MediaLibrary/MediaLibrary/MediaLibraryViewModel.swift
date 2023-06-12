import Core
import UIComponents
import UseCases
import Models

// MARK: - MediaLibraryViewModelInterface

public protocol MediaLibraryViewModelInterface: BaseViewModelInterface {
    var collectionData: [CollectionData] { get }
}

// MARK: - MediaLibraryViewModel

public final class MediaLibraryViewModel: BaseViewModel<
    MediaLibraryViewControllerInterface,
    MediaLibraryViewInterface,
    MediaLibraryConfigModel
> {
    public var collectionData: [CollectionData] = []

    public override func viewLoaded() {
        super.viewLoaded()

        downloadMyMedia { [weak self] in
            self?.view.reloadData()
        }
    }
}

private extension MediaLibraryViewModel {
    func downloadMyMedia(completion: @escaping Action) {
        self.controller.showHud()
        self.config.dependency?.authUseCase.fetchMedia { [weak self] response in
            guard let self else { return }

            self.controller.hideHud()

            switch response {
            case .value(let result):
                self.setupCollection(with: result)
                completion()

            case .error(let error):
                self.controller.showErrorBanner(with: error.message.orEmpty)
            }
        }
    }

    func setupCollection(with media: [ShazamMedia]) {
        self.collectionData = [
            CollectionData(
                section: nil,
                rows: media.map {
                    MediaCollectionViewModel(
                        artist: $0.artistName,
                        song: $0.title,
                        isDownloaded: Bool.random(),
                        imageUrl: $0.albumArtURL,
                        id: UUID().uuidString,
                        delegate: self
                    )
                }
            )
        ]
    }
}

extension MediaLibraryViewModel: MediaCollectionViewModelDelegate {
    func cellDidTap(with id: String) {
        self.config.output?.showPlayer()
    }
}

// MARK: - MediaLibraryViewModel

extension MediaLibraryViewModel: MediaLibraryViewModelInterface {}

// MARK: - MediaLibraryViewModel

extension MediaLibraryViewModel: MediaLibraryInputInterface {}
