import Constants
import Extensions
import Resources
import SnapKit
import Then

// MARK: - Constants

private extension AppearanceConstants {
    var backgroundViewColor: UIColor? { Resources.colors.cffffff.color }
    var borderViewColor: UIColor? { Resources.colors.c191414.color }
    var standardTextColor: UIColor? { Resources.colors.c191414.color }
    var errorColor: UIColor? { Resources.colors.ce50914.color }
    var animationDuration: Double { 0.3 }
    var backgroundViewColorAlpha: Double { 0.2 }
    var errorFont: UIFont { Resources.font(type: .medium, size: 14) }
    var standardFont: UIFont { Resources.font(type: .medium, size: 16) }
    var backgroundViewBorderWidth: CGFloat { 2 }
}

private extension DataConstants {
    var minSymbolsCount: Int { 2 }
}

private extension GridConstants {
    /// Высота view
    var textFieldBackgroundHeight: CGFloat { 52 }
    var errorLabelHeight: CGFloat { 16 }

    var cornerRadius: CGFloat { 2 }
}

//// MARK: - MainTextFieldDelegate
public protocol MainTextFieldDelegate: AnyObject {
    func textFieldEditing(text: String, id: String)
}

// MARK: - MainTextFieldView

public final class MainTextFieldView: UIView {
    // MARK: - Public Properties

    override public var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = grid.textFieldBackgroundHeight
        return size
    }

    public var text: String? {
        get { self.textField.text }
        set { self.textField.text = newValue }
    }

    public var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }

    public var errorKey: String? {
        didSet {
            self.errorLabel.text = errorKey
        }
    }

    public var autocapitalizationType: UITextAutocapitalizationType {
        get { self.textField.autocapitalizationType }
        set { self.textField.autocapitalizationType = newValue }
    }

    public var keyboardType: UIKeyboardType {
        get { self.textField.keyboardType }
        set { self.textField.keyboardType = newValue }
    }

    public var isSecureTextEntry: Bool {
        get { self.textField.isSecureTextEntry }
        set { self.textField.isSecureTextEntry = newValue }
    }

    public var isValid: Bool {
        get { self.errorLabel.isHidden }
        set { self.validationBasedSettings(isValid: newValue) }
    }

    private let id: String
    public weak var delegate: MainTextFieldDelegate?

    // MARK: - Subview Properties

    private lazy var textFieldBackgroundView = UIView().then {
        $0.backgroundColor = appearance.backgroundViewColor
        $0.alpha = appearance.backgroundViewColorAlpha
        $0.layer.borderColor = appearance.borderViewColor?.cgColor
        $0.layer.borderWidth = appearance.backgroundViewBorderWidth
        $0.layer.cornerRadius = grid.cornerRadius
    }

    private lazy var textField = UITextField().then {
        $0.delegate = self
        $0.font = appearance.standardFont
        $0.textColor = appearance.standardTextColor
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)
    }

    private lazy var errorLabel = UILabel().then {
        $0.isHidden = true
        $0.font = appearance.errorFont
        $0.textColor = appearance.errorColor
        $0.numberOfLines = .zero
    }

    public init(id: String) {
        self.id = id

        super.init(frame: .zero)

        self.commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        return self.textField.becomeFirstResponder()
    }

    // MARK: - Public Methods

    public func showError(with text: String) {
        self.errorLabel.text = text
        self.validationBasedSettings(isValid: false)
    }

    // MARK: - Private Methods

    private func commonInit() {
        addSubviews(
            [
                self.textFieldBackgroundView,
                self.textField,
                self.errorLabel
            ]
        )
        self.makeConstraints()
    }

    private func makeConstraints() {
        self.errorLabel.snp.makeConstraints {
            $0.height.equalTo(grid.errorLabelHeight)
            $0.leading.trailing.equalToSuperview().inset(grid.space4)
            $0.bottom.equalToSuperview()
        }
        self.textField.snp.makeConstraints {
            $0.height.equalTo(grid.space20)
            $0.top.leading.trailing.equalToSuperview().inset(grid.space16)
        }
        self.textFieldBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(grid.textFieldBackgroundHeight)
        }
        self.snp.makeConstraints {
            $0.height.equalTo(grid.textFieldBackgroundHeight)
        }
    }

    private func validationBasedSettings(isValid: Bool) {
        self.textFieldBackgroundView.layer.borderColor = isValid ?
            appearance.borderViewColor?.cgColor :
            appearance.errorColor?.cgColor
        self.updateErrorLabelFrame(isValid: isValid)
    }

    private func updateErrorLabelFrame(isValid: Bool) {
        self.errorLabel.isHidden = isValid
        UIView.animate(withDuration: appearance.animationDuration) { [weak self] in
            self?.invalidateIntrinsicContentSize()
            self?.superview?.setNeedsLayout()
            self?.superview?.layoutIfNeeded()
        }

        let contentHeight = grid.textFieldBackgroundHeight + grid.errorLabelHeight + grid.space4
        self.snp.updateConstraints {
            $0.height.equalTo(isValid ? grid.textFieldBackgroundHeight : contentHeight)
        }
    }
}

// MARK: - UITextFieldDelegate

extension MainTextFieldView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    @objc
    private func textFieldEditing() {
        self.delegate?.textFieldEditing(text: self.textField.text.orEmpty, id: self.id)
    }
}

