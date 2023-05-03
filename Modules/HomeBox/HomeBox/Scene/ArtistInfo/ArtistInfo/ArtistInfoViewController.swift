import Core

// MARK: - ArtistInfoViewControllerInterface

public protocol ArtistInfoViewControllerInterface: BaseViewControllerInterface {}

// MARK: - ArtistInfoViewController

public final class ArtistInfoViewController: BaseViewController<
    ArtistInfoViewInterface,
    ArtistInfoViewModelInterface
> {
    public override func setup() {
        super.setup()

        pinContentViewBottom()
    }
}

// MARK: - ArtistInfoViewController

extension ArtistInfoViewController: ArtistInfoViewControllerInterface {}
