/// Протокол для основных числовых констант для верстки и
/// определяющий правила по которому верстаются визуальные компоненты
public protocol GridConstants {}

/// Содержит основные базовые числовые константы
public extension GridConstants {
    var zero: CGFloat { .zero }
    var space1: CGFloat { 1 }
    var space2: CGFloat { 2 }
    var space3: CGFloat { 3 }
    var space4: CGFloat { 4 }
    var space6: CGFloat { 6 }
    var space8: CGFloat { 8 }
    var space10: CGFloat { 10 }
    var space12: CGFloat { 12 }
    var space14: CGFloat { 14 }
    var space16: CGFloat { 16 }
    var space18: CGFloat { 18 }
    var space20: CGFloat { 20 }
    var space22: CGFloat { 22 }
    var space24: CGFloat { 24 }
    var space28: CGFloat { 28 }
    var space30: CGFloat { 30 }
    var space32: CGFloat { 32 }
    var space36: CGFloat { 36 }
    var space38: CGFloat { 38 }
    var space40: CGFloat { 40 }
    var space42: CGFloat { 42 }
    var space44: CGFloat { 44 }
    var space48: CGFloat { 48 }
    var space50: CGFloat { 50 }
    var space52: CGFloat { 52 }
    var space54: CGFloat { 54 }
    var space56: CGFloat { 56 }
    var space60: CGFloat { 60 }
    var space64: CGFloat { 64 }
    var space68: CGFloat { 68 }
    var space70: CGFloat { 70 }
    var space72: CGFloat { 72 }
    var space76: CGFloat { 76 }
    var space80: CGFloat { 80 }
    var space82: CGFloat { 82 }
    var space86: CGFloat { 86 }
    var space92: CGFloat { 92 }
    var space94: CGFloat { 94 }
    var space100: CGFloat { 100 }
    var space108: CGFloat { 108 }
    var space110: CGFloat { 110 }
    var space120: CGFloat { 120 }
    var space130: CGFloat { 130 }
    var space140: CGFloat { 140 }
    var space150: CGFloat { 150 }
    var space160: CGFloat { 160 }
    var space200: CGFloat { 200 }
    var space220: CGFloat { 220 }
    var space260: CGFloat { 260 }
}

/// Обертка для GridConstants совместимых типов
public struct GridConstantsWrapper<Base>: GridConstants {
    private let base: Base

    init(_ base: Base) {
        self.base = base
    }
}

/// Протокол описывающий которому должны конформить совместимы с GridConstants типами
public protocol GridConstantsInterface: AnyObject {}

public extension GridConstantsInterface {
    /// Предоставляет namespace обертку для GridConstants совместимых типов.
    var grid: GridConstantsWrapper<Self> { GridConstantsWrapper(self) }
}

extension UIView: GridConstantsInterface {}
extension UIViewController: GridConstantsInterface {}
extension CALayer: GridConstantsInterface {}
