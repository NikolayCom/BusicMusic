import Core

// MARK: - AddSongViewControllerInterface

public protocol AddSongViewControllerInterface: BaseViewControllerInterface {}

// MARK: - AddSongViewController

public final class AddSongViewController: BaseViewController<
    AddSongViewInterface,
    AddSongViewModelInterface
> {

    override public func setup() {
        super.setup()

        pinContentViewFull()
    }
}

// MARK: - AddSongViewController

extension AddSongViewController: AddSongViewControllerInterface {}
