import Core
import Resources

// MARK: - PlayerViewModelInterface

public protocol PlayerViewModelInterface: BaseViewModelInterface {

    func sliderMove(interval: TimeInterval)
    func playPauseTapped()
    func stringFormatterTimeInterval(interval: TimeInterval) -> String
    func timerUpdated()
    func needSetTotalTime()
}

// MARK: - InDevelopingViewModel

public final class PlayerViewModel: BaseViewModel<
    PlayerViewControllerInterface,
    PlayerViewInterface,
    PlayerConfigModel
> {

    override public func viewAppeared() {
        super.viewAppeared()

        guard let player = self.config.dependency?.playerUseCase, player.isPlaying else { return }

        if let song = config.dependency?.playerUseCase.getNowPlayingInfo() {
            self.view.configure(with: song)
        }

        view.updateScreenTime(with: player.duration)
        view.setPauseImage(image: Resources.images.play.image)
    }

    public override func viewLoaded() {
        super.viewLoaded()

        guard let player = self.config.dependency?.playerUseCase else { return }
        player.setupSongs()
        player.prepareSong()
        self.view.configure(with: player.getNowPlayingInfo())
        view.updateScreenTime(with: player.duration)
        player.setUpRemoteTransparentControls()
    }
}

// MARK: - PlayerViewModel

extension PlayerViewModel: PlayerViewModelInterface {
    public func needSetTotalTime() {
        guard let player = self.config.dependency?.playerUseCase else { return }

        view.setTotalTime(time: stringFormatterTimeInterval(interval: player.duration))
    }

    public func timerUpdated() {
        guard let player = self.config.dependency?.playerUseCase else { return }

        view.setSlider(value: Float(player.currentTime))
    }

    public func stringFormatterTimeInterval(interval: TimeInterval) -> String {
        let time = NSInteger(interval)
        let second = time % 60
        let minutes = (time / 60) % 60
        return NSString(format: "%0.2d:%0.2d", minutes, second) as! String
    }

    public func sliderMove(interval: TimeInterval) {
        self.config.dependency?.playerUseCase.slide(with: interval)
    }

    public func playPauseTapped() {
        guard let player = self.config.dependency?.playerUseCase else { return }
        player.playPause()

        let image = player.isPlaying ? Resources.images.pause.image : Resources.images.play.image

        view.setPauseImage(image: image)
        view.updateScreenTime(with: player.duration)
    }
}

// MARK: - PlayerViewModel

extension PlayerViewModel: PlayerInputInterface {}
