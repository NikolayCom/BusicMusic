import Core

// MARK: - MediaLibraryViewControllerInterface

public protocol MediaLibraryViewControllerInterface: BaseViewControllerInterface {}

// MARK: - MediaLibraryViewController

public final class MediaLibraryViewController: BaseViewController<
    MediaLibraryViewInterface,
    MediaLibraryViewModelInterface
> {

    public override func setup() {
        super.setup()

        pinContentViewBottom()
    }
}

// MARK: - MediaLibraryViewController

extension MediaLibraryViewController: MediaLibraryViewControllerInterface {}
