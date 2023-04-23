import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {}

private extension DataConstants {
    var backgroundImage: UIImage { Resources.homeImages.shazamBackground.image }
}

private extension GridConstants {}

// MARK: - ShazamViewInterface

public protocol ShazamViewInterface: BaseViewInterface {}

// MARK: - HomeBoxView

public class ShazamView: BaseView<ShazamViewModelInterface> {
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

private extension ShazamView {
    @objc
    func actionButtonTapped() {
        viewModel.actionButtonTapped()
    }
}

// MARK: - ShazamView

extension ShazamView: ShazamViewInterface {}
