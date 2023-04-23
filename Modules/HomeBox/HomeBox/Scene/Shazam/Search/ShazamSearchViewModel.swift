import Core

// MARK: - ShazamSearchViewModelInterface

public protocol ShazamSearchViewModelInterface: BaseViewModelInterface {
    func startListeningTapped()
}

// MARK: - ShazamSearchViewModel

public final class ShazamSearchViewModel: BaseViewModel<
    ShazamSearchViewControllerInterface,
    ShazamSearchViewInterface,
    ShazamSearchConfigModel
> {
    private var isListening = false {
        willSet {
            newValue ? view.showAnimation() : view.pauseAnimation()
        }
    }

    public override func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - ShazamSearchViewModel

extension ShazamSearchViewModel: ShazamSearchViewModelInterface {
    public func startListeningTapped() {
        isListening.toggle()
    }
}

// MARK: - ShazamSearchViewModel

extension ShazamSearchViewModel: ShazamSearchInputInterface {}
