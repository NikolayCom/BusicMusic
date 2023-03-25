import Core

// MARK: - EmailViewModelInterface

public protocol EmailViewModelInterface: BaseViewModelInterface {
    typealias TextFieldData = (type: String, value: String)
    typealias TextFieldSectionData = [TextFieldData]

    var textFieldsModel: [TextFieldSectionData] { get }
}

// MARK: - EmailViewModel

public final class EmailViewModel: BaseViewModel<
    EmailViewControllerInterface,
    EmailViewInterface,
    EmailConfigModel
> {

    public var textFieldsModel: [TextFieldSectionData] = []

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
        self.textFieldsModel = self.config.screenType.emailScreenDataTypes.map { section in
            return section.map { type in
                return (type: type.placeholder, value: "")
            }
        }

        view.setupTextFields()
    }
}

// MARK: - EmailViewModel

extension EmailViewModel: EmailViewModelInterface {}

// MARK: - EmailViewModel

extension EmailViewModel: EmailInputInterface {}
