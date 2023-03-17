import Core

// MARK: - EmailViewModelInterface

public protocol EmailViewModelInterface: BaseViewModelInterface {}

// MARK: - EmailViewModel

public final class EmailViewModel: BaseViewModel<
    EmailViewControllerInterface,
    EmailViewInterface,
    EmailConfigModel
> {
    public override func viewLoaded() {
        super.viewLoaded()

        configureView()
    }

    // MARK: Private methods

    private func configureView() {
        self.view.setupActionButton(with: self.config.screenType.emailButtonText)
    }
}

// MARK: - EmailViewModel

extension EmailViewModel: EmailViewModelInterface {}

// MARK: - EmailViewModel

extension EmailViewModel: EmailInputInterface {}
