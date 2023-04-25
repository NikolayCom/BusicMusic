import Core

// MARK: - MediaLibraryViewModelInterface

public protocol MediaLibraryViewModelInterface: BaseViewModelInterface {}

// MARK: - MediaLibraryViewModel

public final class MediaLibraryViewModel: BaseViewModel<
    MediaLibraryViewControllerInterface,
    MediaLibraryViewInterface,
    MediaLibraryConfigModel
> {
    public override func viewLoaded() {
        super.viewLoaded()

        self.controller.showHud()
        self.config.dependency?.authUseCase.fetchMedia { [weak self] response in
            guard let self else { return }

            self.controller.hideHud()

            switch response {
            case .value(let result):
                print(result)

            case .error(let error):
                self.controller.showErrorBanner(with: error.message.orEmpty)
            }
        }
    }
}

// MARK: - MediaLibraryViewModel

extension MediaLibraryViewModel: MediaLibraryViewModelInterface {}

// MARK: - MediaLibraryViewModel

extension MediaLibraryViewModel: MediaLibraryInputInterface {}
