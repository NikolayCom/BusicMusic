import Core
import UIComponents
import Constants
import Resources

private extension AppearanceConstants {
    var titleFont: UIFont { Resources.font(type: .bold, size: 16) }
}

private extension DataConstants {
    var imageSize: CGFloat { 100 }
    var downloadButtonSize: CGFloat { 60 }

    var downloadButtonImage: UIImage? { UIImage(systemName: "square.and.arrow.down") }
}

class ArtistInfoCollectionViewCell: BaseCollectionViewCell {
    private var viewModel: ArtistInfoCollectionViewModel!

    private lazy var containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = grid.space4
    }

    private lazy var nameLabel = UILabel().then {
        $0.font = appearance.titleFont
        $0.textColor = appearance.blackColor
        $0.numberOfLines = .zero
    }

    private lazy var typeLabel = UILabel().then {
        $0.font = appearance.subtitleFont
        $0.textColor = appearance.blackColor
        $0.numberOfLines = .zero
    }

    private lazy var genderLabel = UILabel().then {
        $0.font = appearance.subtitleFont
        $0.textColor = appearance.blackColor
        $0.numberOfLines = .zero
    }

    private lazy var countryLabel = UILabel().then {
        $0.font = appearance.subtitleFont
        $0.textColor = appearance.blackColor
        $0.numberOfLines = .zero
    }

    private lazy var disambiguationLabel = UILabel().then {
        $0.font = appearance.subtitleFont
        $0.textColor = appearance.blackColor
        $0.numberOfLines = .zero
    }

    override func setup() {
        super.setup()
    }

    override func setupUI() {
        super.setupUI()

        containerStackView.addArrangedSubviews(
            [
                nameLabel,
                typeLabel,
                genderLabel,
                countryLabel,
                disambiguationLabel,
                DividerView()
            ]
        )

        addSubview(containerStackView)
    }

    override func setupConstraints() {
        super.setupConstraints()

        containerStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(grid.space8)
            $0.leading.trailing.equalToSuperview().inset(grid.space20)
        }
    }
}

extension ArtistInfoCollectionViewCell: ConfigurableView {
    func configure(with viewModel: ArtistInfoCollectionViewModel) {
        self.viewModel = viewModel

        self.nameLabel.text = "Name: \(viewModel.name ?? "-\\-")"
        self.typeLabel.text = "Type: \(viewModel.type ?? "-\\-")"
        self.genderLabel.text = "Gender: \(viewModel.gender ?? "-\\-")"
        self.countryLabel.text = "Country: \(viewModel.country ?? "-\\-")"
        self.disambiguationLabel.text = "Disambiguation: \(viewModel.disambiguation ?? "-\\-")"
    }
}
