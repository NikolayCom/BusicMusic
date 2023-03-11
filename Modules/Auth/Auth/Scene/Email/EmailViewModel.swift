import Core

// MARK: - EmailViewModelInterface

protocol EmailViewModelInterface: BaseViewModelInterface {}

// MARK: - EmailViewController

final class EmailViewModel: BaseViewModel<
    EmailViewControllerInterface,
    EmailViewInterface,
    EmailConfigModel
> {
    override func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - EmailViewModelInterface

extension EmailViewModel: EmailViewModelInterface {}

// MARK: - EmailInputInterface

extension EmailViewModel: EmailInputInterface {}
