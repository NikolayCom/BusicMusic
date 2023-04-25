import Core

// MARK: - MediaLibraryWidgetViewModelInterface

public protocol MediaLibraryWidgetViewModelInterface: BaseViewModelInterface {
    func actionButtonTapped()
}

// MARK: - MediaLibraryWidgetViewModel

public final class MediaLibraryWidgetViewModel: BaseViewModel<
    MediaLibraryWidgetViewControllerInterface,
    MediaLibraryWidgetViewInterface,
    MediaLibraryWidgetConfigModel
> {
    public override func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - MediaLibraryWidgetViewModel

extension MediaLibraryWidgetViewModel: MediaLibraryWidgetViewModelInterface {
    public func actionButtonTapped() {
        self.config.output?.showLibrary()
    }
}

// MARK: - MediaLibraryWidgetViewModel

extension MediaLibraryWidgetViewModel: MediaLibraryWidgetInputInterface {}
