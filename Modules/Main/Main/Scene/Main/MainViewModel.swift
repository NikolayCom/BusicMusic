import Core

// MARK: - MainViewModelInterface

public protocol MainViewModelInterface: BaseViewModelInterface {}

// MARK: - MainViewModel

public final class MainViewModel: BaseViewModel<
    MainViewControllerInterface,
    MainViewInterface,
    MainConfigModel
> {
    public override func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - MainViewModel

extension MainViewModel: MainViewModelInterface {}

// MARK: - MainViewModel

extension MainViewModel: MainInputInterface {}
