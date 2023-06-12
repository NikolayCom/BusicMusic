import Core
import Constants
import Resources
import UIComponents
import Lottie
import Pulsator

// MARK: - Constants

private extension AppearanceConstants {
    var titleFont: UIFont { Resources.font(type: .extraBold, size: 50) }
    var textColor: UIColor? { self.blackColor }

    var infoTitleFont: UIFont { Resources.font(type: .bold, size: 18) }
    var infoSubtitleFont: UIFont { Resources.font(type: .regular, size: 14) }

    var infoTitleTextColor: UIColor? { self.blackColor }
    var infoSubTitleTextColor: UIColor? { self.blackColor.withAlphaComponent(0.7) }

    var beginAnimationProgress: CGFloat { 0.0 }
    var endAnimationProgress: CGFloat { 1 }
    var animationSpeed: CGFloat { 0.5 }
}

private extension DataConstants {
    var title: String { Resources.strings.Shazam.Main.title }

    var infoTitle: String { Resources.strings.Shazam.Main.infoTitle }
    var infoSubtitle: String { Resources.strings.Shazam.Main.infoSubtitle }

    var cancelButtonTitle: String { Resources.strings.Common.cancel }

    var animationName: String { "shazam-search-animation" }
    var pulseAnimationKey: String { "opacity" }
}

private extension GridConstants {}

// MARK: - ShazamSearchViewInterface

public protocol ShazamSearchViewInterface: BaseViewInterface {
    func showAnimation()
    func pauseAnimation()
}

// MARK: - ShazamSearchView

public class ShazamSearchView: BaseView<ShazamSearchViewModelInterface> {
    private lazy var titleLabel = UILabel().then {
        $0.font = appearance.titleFont
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = appearance.textColor
        $0.text = data.title
        $0.adjustsFontSizeToFitWidth = true
    }

    private lazy var buttonAnimationView = LottieAnimationView(name: data.animationName).then {
        $0.contentMode = .scaleAspectFit
        $0.animationSpeed = appearance.animationSpeed
        $0.layer.add(pulseAnimation, forKey: data.pulseAnimationKey)
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionTapped)))
    }

    private lazy var pulseAnimation = CABasicAnimation(keyPath: data.pulseAnimationKey).then {
        $0.duration = 2
        $0.fromValue = 0.5
        $0.toValue = 1
        $0.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        $0.autoreverses = true
        $0.repeatCount = .greatestFiniteMagnitude
    }

    private lazy var pulsatorLayer = Pulsator().then {
        $0.numPulse = 3
        $0.animationDuration = 3
        $0.radius = frame.width.half() + grid.space30
        $0.backgroundColor = appearance.blackColor.cgColor
    }

    private lazy var infoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = grid.space8
        $0.isHidden = true
    }

    private lazy var infoTitleLabel = UILabel().then {
        $0.font = appearance.infoTitleFont
        $0.textColor = appearance.infoTitleTextColor
        $0.textAlignment = .center
        $0.text = data.infoTitle
    }

    private lazy var infoSubtitleLabel = UILabel().then {
        $0.font = appearance.infoSubtitleFont
        $0.textColor = appearance.infoSubTitleTextColor
        $0.textAlignment = .center
        $0.text = data.infoSubtitle
        $0.numberOfLines = .zero
    }

    // MARK: - Life cycle

    public override func viewWillAppear() {
        super.viewWillAppear()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        pulsatorLayer.frame.origin = buttonAnimationView.center
    }

    // MARK: - Setups

    public override func setup() {
        super.setup()
    }

    public override func setupUI() {
        super.setupUI()

        layer.insertSublayer(pulsatorLayer, at: .zero)

        self.infoStackView.addArrangedSubviews(
            [
                self.infoTitleLabel,
                self.infoSubtitleLabel
            ]
        )

        self.addSubviews(
            [
                self.titleLabel,
                self.buttonAnimationView,
                self.infoStackView
            ]
        )
    }

    public override func setupConstraints() {
        super.setupConstraints()

        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(grid.space32)
            $0.leading.equalToSuperview().inset(grid.space16)
            $0.trailing.equalToSuperview().inset(grid.space40)
        }

        self.buttonAnimationView.snp.makeConstraints {
            $0.centerY.equalToSuperview().inset(-grid.space60)
            $0.trailing.leading.equalToSuperview().inset(grid.space40)
            $0.height.equalTo(buttonAnimationView.snp.width)
        }

        self.infoStackView.snp.makeConstraints {
            $0.top.equalTo(buttonAnimationView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(grid.space40)
        }
    }

    // MARK: - Private methods

    private func showAnimation(beginProgress: CGFloat) {
        self.buttonAnimationView.play(
            fromProgress: appearance.beginAnimationProgress,
            toProgress: appearance.endAnimationProgress,
            loopMode: .autoReverse
        )
    }

    // MARK: Actions

    @objc
    private func actionTapped() {
        viewModel.startListeningTapped()
    }
}

// MARK: - ShazamSearchView

extension ShazamSearchView: ShazamSearchViewInterface {
    public func showAnimation() {
        infoStackView.isHidden = false
        buttonAnimationView.layer.removeAnimation(forKey: data.pulseAnimationKey)

        self.showAnimation(beginProgress: appearance.beginAnimationProgress)
        self.pulsatorLayer.start()
    }

    public func pauseAnimation() {
        infoStackView.isHidden = true

        self.buttonAnimationView.stop()
        self.pulsatorLayer.stop()

        buttonAnimationView.layer.add(pulseAnimation, forKey: data.pulseAnimationKey)
    }
}
