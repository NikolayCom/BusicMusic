import Constants
import Core
import SDWebImage
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {
    var titleFont: UIFont { Resources.font(type: .bold, size: 22) }
    var subtitleFont: UIFont { Resources.font(type: .italic, size: 20) }
}

private extension DataConstants {
    var addButtonText: String { Resources.strings.Common.add }
    var cancelButtonText: String { Resources.strings.Common.cancel }
}

private extension GridConstants {}

// MARK: - AddSongViewInterface

public protocol AddSongViewInterface: BaseViewInterface {
    func configureViewWith(title: String?, subtitle: String?, imageUrl: URL?)
}

// MARK: - DefaultView

public class AddSongView: BaseView<AddSongViewModelInterface> {
    private lazy var containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = grid.space20
    }

    private lazy var artistImageView = UIImageView().then {
        $0.contentMode = .redraw
        $0.layer.cornerRadius = grid.space4
        $0.clipsToBounds = true
    }

    private lazy var labelsContainerStackView = UIStackView().then {
        $0.spacing = grid.space10
        $0.axis = .vertical
    }

    private lazy var titleLabel = UILabel().then {
        $0.font = appearance.titleFont
    }

    private lazy var subtitleLabel = UILabel().then {
        $0.font = appearance.subtitleFont
    }

    private lazy var buttonsContainerStackView = UIStackView().then {
        $0.distribution = .fillEqually
    }

    private lazy var addButton = MainButton(type: .clean, style: .light).then {
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        $0.setTitle(data.addButtonText, for: .normal)
        $0.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
    }

    private lazy var cancelButton = MainButton(type: .clean, style: .dark).then {
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        $0.setTitle(data.cancelButtonText, for: .normal)
        $0.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Setups

    override public func setup() {
        super.setup()
    }

    override public func setupUI() {
        super.setupUI()

        self.buttonsContainerStackView.addArrangedSubviews(
            [
                self.cancelButton,
                UIView(),
                self.addButton
            ]
        )

        self.labelsContainerStackView.addArrangedSubviews(
            [
                self.titleLabel,
                self.subtitleLabel
            ]
        )

        self.containerStackView.addArrangedSubviews(
            [
                artistImageView,
                labelsContainerStackView,
                UIView(),
                buttonsContainerStackView
            ]
        )

        addSubviews(
            [
                containerStackView
            ]
        )
    }

    override public func setupConstraints() {
        super.setupConstraints()

        self.containerStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(grid.space20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(grid.space30)
        }

        self.artistImageView.snp.makeConstraints {
            $0.height.equalTo(artistImageView.snp.width)
        }
    }
}

// MARK: Private

private extension AddSongView {
    // MARK: Actions

    @objc
    func addButtonDidTap() {
        viewModel.addButtonTapped()
    }

    @objc
    func cancelButtonDidTap() {
        viewModel.cancelButtonTapped()
    }
}

// MARK: - AddSongView
extension AddSongView: AddSongViewInterface {
    public func configureViewWith(title: String?, subtitle: String?, imageUrl: URL?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle

        LoadImageView.loadImage(
            stringUrl: (imageUrl?.absoluteString).orEmpty,
            placeholder: nil
        ) { [weak self] image, _ in
            self?.artistImageView.image = image
        }
    }
}
