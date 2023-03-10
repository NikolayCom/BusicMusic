import Foundation

public enum Convert {
    // MARK: - From

    public static func from<Type>(_ value: Any?) -> Type? {
        guard let castedValue = value as? Type else { return nil }

        return castedValue
    }

    // MARK: - Dictionary

    public static func get<KeyType: Hashable, ValueType>(
        key: KeyType,
        from dict: [KeyType: Any]
    ) -> ValueType? {
        guard let value = dict[key] else { return nil }
        return Convert.from(value)
    }
}
