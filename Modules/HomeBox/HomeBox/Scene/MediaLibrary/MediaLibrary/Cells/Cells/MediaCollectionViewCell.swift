import Core
import UIComponents
import Constants
import Resources

private extension AppearanceConstants {
    var titleFont: UIFont { Resources.font(type: .bold, size: 16) }
    var subtitleFont: UIFont { Resources.font(type: .bold, size: 14) }
}

private extension DataConstants {
    var imageSize: CGFloat { 100 }
    var downloadButtonSize: CGFloat { 60 }

    var downloadButtonImage: UIImage? { UIImage(systemName: "square.and.arrow.down") }
}

class MediaCollectionViewCell: BaseCollectionViewCell {
    private var viewModel: MediaCollectionViewModel!

    private lazy var artistImageView = LoadImageView().then {
        $0.isUserInteractionEnabled = false
    }

    private lazy var contentContainerStackView = UIStackView().then {
        $0.spacing = grid.space8
    }

    private lazy var containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = grid.space4
    }

    private lazy var titleContainerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.isUserInteractionEnabled = false
    }

    private lazy var titleLabel = UILabel().then {
        $0.font = appearance.titleFont
        $0.textColor = appearance.blackColor
    }

    private lazy var subtitleLabel = UILabel().then {
        $0.font = appearance.subtitleFont
        $0.textColor = appearance.blackColor
    }

    private lazy var downloadButton = UIButton().then {
        $0.setImage(data.downloadButtonImage, for: .normal)
        $0.imageView?.tintColor = appearance.blackColor
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        $0.imageEdgeInsets = .init(top: grid.space10, left: grid.space10, bottom: grid.space10, right: grid.space10)
    }

    private lazy var downloadButtonStackView = UIStackView().then {
        $0.axis = .vertical
    }

    override func setup() {
        super.setup()

        contentContainerStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }

    override func setupUI() {
        super.setupUI()

        titleContainerStackView.addArrangedSubviews(
            [
                titleLabel,
                subtitleLabel
            ]
        )

        downloadButtonStackView.addArrangedSubviews(
            [
                UIView(),
                downloadButton,
                UIView()
            ]
        )

        contentContainerStackView.addArrangedSubviews(
            [
                artistImageView,
                titleContainerStackView,
                downloadButtonStackView
            ]
        )

        containerStackView.addArrangedSubviews(
            [
                contentContainerStackView,
                DividerView()
            ]
        )

        contentView.addSubview(containerStackView)
    }

    override func setupConstraints() {
        super.setupConstraints()

        containerStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(grid.space8)
            $0.leading.trailing.equalToSuperview().inset(grid.space4)
        }

        artistImageView.snp.makeConstraints {
            $0.size.equalTo(data.imageSize)
        }

        downloadButton.snp.makeConstraints {
            $0.size.equalTo(data.downloadButtonSize)
        }
    }

    // MARK: Actions

    @objc
    func didTap() {
        viewModel.delegate?.cellDidTap(with: viewModel.id)
    }
}

extension MediaCollectionViewCell: ConfigurableView {
    func configure(with viewModel: MediaCollectionViewModel) {
        self.viewModel = viewModel

        self.titleLabel.text = viewModel.artist
        self.subtitleLabel.text = viewModel.song

        self.artistImageView.setImage(url: viewModel.imageUrl, placeholder: nil)

        self.downloadButton.isHidden = viewModel.isDownloaded
    }
}
