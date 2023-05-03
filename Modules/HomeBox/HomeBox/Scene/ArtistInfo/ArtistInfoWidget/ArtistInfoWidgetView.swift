import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {}

private extension DataConstants {
    var backgroundImage: UIImage { Resources.homeImages.artistInfoBackground.image }
}

private extension GridConstants {}

// MARK: - ArtistInfoWidgetViewInterface

public protocol ArtistInfoWidgetViewInterface: BaseViewInterface {}

// MARK: - ArtistInfoWidgetView

public class ArtistInfoWidgetView: BaseView<ArtistInfoWidgetViewModelInterface> {
    private lazy var imageView = UIImageView(image: data.backgroundImage).then {
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionButtonTapped)))
    }
    
    // MARK: - Setups

    public override func setup() {
        super.setup()
    }

    public override func setupUI() {
        super.setupUI()

        addSubviews(
            [
                imageView
            ]
        )
    }

    public override func setupConstraints() {
        super.setupConstraints()

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

private extension ArtistInfoWidgetView {
    @objc
    func actionButtonTapped() {
        viewModel.actionButtonTapped()
    }
}

// MARK: - ArtistInfoWidgetView

extension ArtistInfoWidgetView: ArtistInfoWidgetViewInterface {}
