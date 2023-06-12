import Constants
import Core
import MediaPlayer
import Models
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {
    var timeFont: UIFont { Resources.font(type: .medium, size: 12) }

    var nameFont: UIFont { Resources.font(type: .medium, size: 12) }
    var titleFont: UIFont { Resources.font(type: .medium, size: 18) }
}

private extension DataConstants {}

private extension GridConstants {}

// MARK: - PlayerViewInterface

public protocol PlayerViewInterface: BaseViewInterface {
    func configure(with song: Song)
    func updateScreenTime(with interval: TimeInterval)
    func setPauseImage(image: UIImage)
    func setSlider(value: Float)
    func setTotalTime(time: String)
}

// MARK: - PlayerView

public class PlayerView: BaseView<PlayerViewModelInterface> {
    private lazy var playerIconsStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = grid.space10
    }

    private lazy var songInfoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalCentering
        $0.spacing = grid.space8
    }

    private lazy var playButton = UIButton().then {
        $0.setImage(Resources.images.play.image, for: .normal)
        $0.addTarget(self, action: #selector(playPause), for: .touchUpInside)
    }

    private lazy var mixButton = UIButton().then {
        $0.setImage(Resources.images.mix.image, for: .normal)
        // btn.addTarget(self, action: #selector(_mix), for: .touchUpInside)
    }

    private lazy var backButton = UIButton().then {
        // let btn = UIButton(type: .system)
        $0.setImage(Resources.images.back.image, for: .normal)
        // btn.addTarget(self, action: #selector(_back), for: .touchUpInside)
    }

    private lazy var nextButton = UIButton().then {
        $0.setImage(Resources.images.next.image, for: .normal)
        // btn.addTarget(self, action: #selector(_next), for: .touchUpInside)
    }

    private lazy var slider = UISlider().then {
        $0.maximumValue = 1000
        $0.minimumValue = .zero
        $0.tintColor = appearance.blackColor
        $0.addTarget(self, action: #selector(sliderAction), for: .touchDragInside)
    }

    private lazy var timeLabel = UILabel().then {
        $0.text = "-:--"
        $0.font = appearance.timeFont
        $0.textColor = appearance.blackColor
    }

    private lazy var totalTimeLabel = UILabel().then {
        $0.text = "-:--"
        $0.font = appearance.timeFont
        $0.textColor = appearance.blackColor
    }

    private lazy var artistNameLabel = UILabel().then {
        $0.text = "unknown"
        $0.font = appearance.nameFont
        $0.textColor = UIColor.lightGray
    }

    private lazy var songTitleLabel = UILabel().then {
        $0.text = "unknown"
        $0.font = appearance.titleFont
        $0.textColor = appearance.blackColor
    }

    private lazy var artistImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.contentMode = .scaleAspectFill
    }

    // MARK: - Setups

    public override func setup() {
        super.setup()
    }

    public override func setupUI() {
        super.setupUI()

        playerIconsStackView.addArrangedSubviews(
            [
                backButton,
                nextButton,
                mixButton,
                playButton
            ]
        )

        songInfoStackView.addArrangedSubviews(
            [
                songTitleLabel,
                artistNameLabel
            ]
        )

        addSubviews(
            [
                playerIconsStackView,
                slider,
                timeLabel,
                totalTimeLabel,
                songInfoStackView,
                artistImageView
            ]
        )
    }

    override public func setupConstraints() {
        super.setupConstraints()

        playerIconsStackView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(grid.space60)
            $0.leading.trailing.equalToSuperview().inset(grid.space20)
        }

        slider.snp.makeConstraints {
            $0.bottom.equalTo(playerIconsStackView.snp.top).inset(-grid.space12)
            $0.leading.trailing.equalToSuperview().inset(grid.space30)
        }

        timeLabel.snp.makeConstraints {
            $0.bottom.equalTo(slider.snp.top).inset(-grid.space8)
            $0.leading.equalToSuperview().inset(grid.space30)
        }

        totalTimeLabel.snp.makeConstraints {
            $0.bottom.equalTo(slider.snp.top).inset(-grid.space8)
            $0.trailing.equalToSuperview().inset(grid.space30)
        }

        songInfoStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(artistImageView.snp.bottom).inset(-grid.space20)
            $0.bottom.equalTo(totalTimeLabel.snp.top).inset(-grid.space12)
        }

        artistImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(grid.space20)
            $0.leading.trailing.equalToSuperview().inset(grid.space20)
            $0.height.equalTo(artistImageView.snp.width)
        }
    }

    @objc
    func sliderAction () {
        viewModel.sliderMove(interval: TimeInterval(slider.value))
    }

    @objc
    func playPause() {
        viewModel.playPauseTapped()
    }

    @objc
    func update(timer: Timer) {
        viewModel.timerUpdated()
        timeLabel.text = viewModel.stringFormatterTimeInterval(interval: TimeInterval(slider.value))
    }
}

// MARK: - PlayerView

extension PlayerView: PlayerViewInterface {
    public func setTotalTime(time: String) {
        totalTimeLabel.text = time
    }

    public func setSlider(value: Float) {
        slider.value = value
    }

    public func updateScreenTime(with interval: TimeInterval) {
        Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(self.update),
            userInfo: nil,
            repeats: true
        )
        slider.maximumValue = Float(interval)
        viewModel.needSetTotalTime()
    }

    public func setPauseImage(image: UIImage) {
        playButton.setImage(image, for: .normal)
    }

    public func configure(with song: Song) {
        let images = Resources.images

        artistImageView.image = [images.animals, images.hello, images.someoneLikeYou].randomElement()?.image
        artistNameLabel.text = song.artistName
        songTitleLabel.text = song.songTitle
    }
}
