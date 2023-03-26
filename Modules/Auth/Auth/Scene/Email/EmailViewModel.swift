import Core
import UIComponents
import Models
import UseCases

// MARK: - EmailViewModelInterface

public protocol EmailViewModelInterface: BaseViewModelInterface, MainTextFieldDelegate {
    typealias TextFieldSectionData = [AuthRequiredDataType]

    var textFieldsModel: [TextFieldSectionData] { get }

    func actionButtonDidTap()
}

// MARK: - EmailViewModel

public final class EmailViewModel: BaseViewModel<
    EmailViewControllerInterface,
    EmailViewInterface,
    EmailConfigModel
> {

    public var textFieldsModel: [TextFieldSectionData] = []

    public var userModel = EmailUser()

    public override func viewLoaded() {
        super.viewLoaded()

        configureView()
    }

    // MARK: Private methods

    private func configureView() {
        let screenType = self.config.screenType
        self.view.setupActionButton(with: screenType.emailButtonText)

        if let titleText = screenType.emailTitleSubtitle {
            self.view.setupTitleText(title: titleText.title, subtitle: titleText.subtitle)
        }

        self.setupTextFields()
    }

    private func setupTextFields() {
        self.textFieldsModel = self.config.screenType.emailScreenDataTypes

        view.setupTextFields()
    }

    private func performEmailAuth(completion: @escaping Action) {
        self.config.dependency?.authUseCase.authWithEmailAccount(
            with: self.userModel, screenType: self.config.screenType
        ) { [weak self] result in
            guard let self = self else { return }
            self.controller.hideHud()

            switch result {
            case .value:
                completion()

            case .error(let error):
                self.controller.showErrorBanner(with: error.message.orEmpty)
            }
        }
    }
}

// MARK: - EmailViewModel

extension EmailViewModel: EmailViewModelInterface {
    public func actionButtonDidTap() {
        self.controller.showHud()
        self.performEmailAuth { [weak self] in
            self?.config.output?.showMain()
        }
    }
}

// MARK: - EmailViewModel

extension EmailViewModel: EmailInputInterface {}

// MARK: - MainTextFieldDelegate

extension EmailViewModel: MainTextFieldDelegate {
    public func textFieldEditing(text: String, id: String) {
        guard let type = AuthRequiredDataType(rawValue: id) else { return }
        self.userModel.setValue(with: type, value: text)
    }
}
