import Core

// MARK: - ProfileViewControllerInterface

public protocol ProfileViewControllerInterface: BaseViewControllerInterface {}

// MARK: - ProfileViewController

public final class ProfileViewController: BaseViewController<
    ProfileViewInterface,
    ProfileViewModelInterface
> {

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    public override func setup() {
        super.setup()

        pinContentViewBottom()
    }
}

// MARK: - ProfileViewController

extension ProfileViewController: ProfileViewControllerInterface {}
