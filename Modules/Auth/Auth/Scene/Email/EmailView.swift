import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {}

private extension DataConstants {}

private extension GridConstants {}

// MARK: - EmailViewInterface

public protocol EmailViewInterface: BaseViewInterface {
    func setupActionButton(with title: String)
}

// MARK: - EmailView

public class EmailView: BaseView<EmailViewModelInterface> {
    private lazy var actionButton = MainButton(type: .continue).then {
        $0.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }

    // MARK: - Setups

    public override func setupUI() {
        super.setupUI()

        self.addSubviews(
            [
                self.actionButton
            ]
        )
    }

    public override func setupConstraints() {
        super.setupConstraints()

        self.actionButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(grid.space44)
            $0.leading.trailing.equalToSuperview().inset(grid.space30)
        }
    }

    // MARK: Actions

    @objc func actionButtonTapped() {}
}

// MARK: - EmailView

extension EmailView: EmailViewInterface {
    public func setupActionButton(with title: String) {
        self.actionButton.setTitle(title, for: .normal)
    }
}
