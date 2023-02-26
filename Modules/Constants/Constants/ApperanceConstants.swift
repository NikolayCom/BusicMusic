import Resources

/// Протокол для основных числовых констант для верстки содержащий цвета, альфы и прочngее
public protocol AppearanceConstants {}

/// Содержит основные базовые числовые константы
public extension AppearanceConstants {
    var clearColor: UIColor { .clear }
    var whiteColor: UIColor { Resources.colors.cffffff.color }
    var blackColor: UIColor { Resources.colors.c191414.color }
    var redColor: UIColor { Resources.colors.ce50914.color }
}

/// Обертка для AppearanceConstant совместимых типов
public struct AppearanceConstantsWrapper<Base>: AppearanceConstants {
    private let base: Base

    init(base: Base) {
        self.base = base
    }
}

/// Протокол описывающий которому должны конформить совместимы с AppearanceConstant типами
public protocol AppearanceConstantsInterface: AnyObject {}

public extension AppearanceConstantsInterface {
    /// Предоставляет namespace обертку для AppearanceConstant совместимых типов.
    var appearance: AppearanceConstantsWrapper<Self> { AppearanceConstantsWrapper(base: self) }
}

extension UIView: AppearanceConstantsInterface {}
extension UIViewController: AppearanceConstantsInterface {}
extension CALayer: AppearanceConstantsInterface {}
