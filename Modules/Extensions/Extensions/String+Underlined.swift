public extension String {
    var underlined: NSAttributedString? {
        NSAttributedString(
            string: self,
            attributes: [
                .underlineStyle: NSUnderlineStyle.thick.rawValue
            ]
        )
    }
}
