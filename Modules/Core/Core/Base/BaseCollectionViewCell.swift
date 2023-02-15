import Foundation
import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    override public init(frame: CGRect) {
        super.init(frame: frame)

        self.commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.commonInit()
    }

    private func commonInit() {
        self.setup()
        self.setupUI()
        self.setupConstraints()
    }

    open func setup() {}

    open func setupUI() {}

    open func setupConstraints() {}
}

open class BaseCollectionReusableView: UICollectionReusableView {
    override public init(frame: CGRect) {
        super.init(frame: frame)

        self.commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.commonInit()
    }

    private func commonInit() {
        self.setup()
        self.setupUI()
        self.setupConstraints()
    }

    open func setup() {}

    open func setupUI() {}

    open func setupConstraints() {}
}
