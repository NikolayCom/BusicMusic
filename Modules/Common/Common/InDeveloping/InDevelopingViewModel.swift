import Core

// MARK: - InDevelopingViewModelInterface

public protocol InDevelopingViewModelInterface: BaseViewModelInterface {}

// MARK: - InDevelopingViewModel

public final class InDevelopingViewModel: BaseViewModel<
    InDevelopingViewControllerInterface,
    InDevelopingViewInterface,
    InDevelopingConfigModel
> {
    public override func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - InDevelopingViewModel

extension InDevelopingViewModel: InDevelopingViewModelInterface {}

// MARK: - InDevelopingViewModel

extension InDevelopingViewModel: InDevelopingInputInterface {}
