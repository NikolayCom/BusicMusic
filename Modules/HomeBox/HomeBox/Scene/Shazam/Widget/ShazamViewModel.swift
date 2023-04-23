import Core

// MARK: - ShazamViewModelInterface

public protocol ShazamViewModelInterface: BaseViewModelInterface {
    func actionButtonTapped()
}

// MARK: - ShazamViewModel

public final class ShazamViewModel: BaseViewModel<
    ShazamViewControllerInterface,
    ShazamViewInterface,
    ShazamConfigModel
> {
    public override func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - ShazamViewModel

extension ShazamViewModel: ShazamViewModelInterface {
    public func actionButtonTapped() {
        self.config.output?.showShazamView()
    }
}

// MARK: - ShazamViewModel

extension ShazamViewModel: ShazamInputInterface {}
