import Core

// MARK: - ShazamSearchViewModelInterface

public protocol ShazamSearchViewModelInterface: BaseViewModelInterface {
    func startListeningTapped()
}

private enum Constants {
    static var requestTime: Double { 3 }
}

// MARK: - ShazamSearchViewModel

public final class ShazamSearchViewModel: BaseViewModel<
    ShazamSearchViewControllerInterface,
    ShazamSearchViewInterface,
    ShazamSearchConfigModel
> {
    private var searchingTimer: Timer?

    private var isListening = false {
        willSet {
            searchingTimer?.invalidate()
            if newValue {
                view.showAnimation()
                startTimer()
            } else {
                view.pauseAnimation()
            }
        }
    }

    public override func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - Private

private extension ShazamSearchViewModel {
    func startTimer() {
        self.searchingTimer = Timer.scheduledTimer(
            withTimeInterval: Constants.requestTime,
            repeats: false
        ) { [weak self] _ in
            self?.isListening = false
            self?.config.output?.showAddSong()
        }
    }
}

// MARK: - ShazamSearchViewModel

extension ShazamSearchViewModel: ShazamSearchViewModelInterface {
    public func startListeningTapped() {
        isListening.toggle()

        // MARK: Добавить в аккаунт разработчика: https://developer.apple.com/account/resources/
        if isListening, false {
            self.config.dependency?.shazamUseCase.startListening { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .value(let media):
                    print(media.title)

                case .error(let error):
                    self.controller.showErrorBanner(with: error.message.orEmpty)
                }
            }
        }
    }
}

// MARK: - ShazamSearchViewModel

extension ShazamSearchViewModel: ShazamSearchInputInterface {}
