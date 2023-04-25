import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {
    var titleFont: UIFont { Resources.font(type: .extraBold, size: 50) }
    var textColor: UIColor? { self.blackColor }
}

private extension DataConstants {
    var title: String { Resources.strings.HomeBox.MyLibrary.desc }
}

private extension GridConstants {}

// MARK: - MediaLibraryViewInterface

public protocol MediaLibraryViewInterface: BaseViewInterface {}

// MARK: - MediaLibraryView

public class MediaLibraryView: BaseView<MediaLibraryViewModelInterface> {
    private lazy var titleLabel = UILabel().then {
        $0.font = appearance.titleFont
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = appearance.textColor
        $0.text = data.title
        $0.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - Setups

    public override func setup() {
        super.setup()
    }

    public override func setupUI() {
        super.setupUI()

        addSubviews(
            [
                self.titleLabel
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
    }
}

// MARK: - MediaLibraryView

extension MediaLibraryView: MediaLibraryViewInterface {}
