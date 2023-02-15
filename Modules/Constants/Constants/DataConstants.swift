/// Протокол для основных числовых констант для верстки содержащий цвета, альфы и прочngее
public protocol DataConstants {}

/// Содержит основные базовые числовые константы
public extension DataConstants {}

/// Обертка для DataConstants совместимых типов
public struct DataConstantsWrapper<Base>: DataConstants {
    private let base: Base

    init(_ base: Base) {
        self.base = base
    }
}

/// Протокол описывающий которому должны конформить совместимы с DataConstants типами
public protocol DataConstantsInterface: AnyObject {}

public extension DataConstantsInterface {
    /// Предоставляет namespace обертку для DataConstants совместимых типов.
    var data: DataConstantsWrapper<Self> { DataConstantsWrapper(self) }
}

extension UIView: DataConstantsInterface {}
extension UIViewController: DataConstantsInterface {}
extension CALayer: DataConstantsInterface {}
