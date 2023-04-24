import Core

// MARK: - AddSongViewControllerInterface

public protocol AddSongViewControllerInterface: BaseViewControllerInterface {}

// MARK: - AddSongViewController

public final class AddSongViewController: BaseViewController<
    AddSongViewInterface,
    AddSongViewModelInterface
> {

    public override func setup() {
        super.setup()

        pinContentViewFull()
    }
}

// MARK: - AddSongViewController

extension AddSongViewController: AddSongViewControllerInterface {}
