/// Класс для работы с моделями устройств
public enum DeviceModelHelper {
    public static func isIphoneX() -> Bool {
        let screenSize = UIScreen.main.bounds.size
        return UI_USER_INTERFACE_IDIOM() == .phone && max(screenSize.width, screenSize.height) == 812.0
    }

    public static func isIphoneSE() -> Bool {
        let screenSize = UIScreen.main.bounds.size
        return (screenSize.height <= 569 && screenSize.width <= 321)
    }

    public static func isSmallDevice() -> Bool {
        let screenSize = UIScreen.main.bounds.size
        return (screenSize.height <= 668 && screenSize.width <= 376)
    }
}
