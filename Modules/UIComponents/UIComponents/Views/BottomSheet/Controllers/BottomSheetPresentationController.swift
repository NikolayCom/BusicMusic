import Foundation

// MARK: - BottomSheetPresentationController

class BottomSheetPresentationController: UIPresentationController {
    var driver: TransitionDriver!

    // MARK: - Override methods

    override public var shouldPresentInFullscreen: Bool {
        false
    }

    override public var frameOfPresentedViewInContainerView: CGRect {
        self.targetFrameForPresentedView()
    }

    override public func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        self.updatePresentedViewSize()
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let presentedView = presentedView else { return }
        containerView?.addSubview(presentedView)
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)

        guard completed else { return }

        self.driver?.direction = .dismiss
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()

        presentedView?.frame = self.frameOfPresentedViewInContainerView
    }

    // MARK: - Private methods

    private func targetFrameForPresentedView() -> CGRect {
        guard let containerView = containerView, let windowInsets = presentedView?.window?.safeAreaInsets else {
            return .zero
        }

        let preferredHeight = presentedViewController.preferredContentSize.height + windowInsets.bottom
        let maxHeight = containerView.bounds.height - windowInsets.top
        let height = min(preferredHeight, maxHeight)

        return .init(
            x: .zero,
            y: containerView.bounds.height - height,
            width: containerView.bounds.width,
            height: height
        )
    }

    private func updatePresentedViewSize() {
        guard let presentedView = presentedView else { return }

        let oldFrame = presentedView.frame
        let targetFrame = self.targetFrameForPresentedView()

        guard !oldFrame.isAlmostEqual(to: targetFrame) else { return }
        presentedView.frame = targetFrame
    }
}

// MARK: - Extensions

private extension CGRect {
    // MARK: - Equality

    func isAlmostEqual(to other: CGRect) -> Bool {
        size.isAlmostEqual(to: other.size) && origin.isAlmostEqual(to: other.origin)
    }

    func isAlmostEqual(to other: CGRect, error: CGFloat) -> Bool {
        size.isAlmostEqual(to: other.size, error: error) && origin.isAlmostEqual(to: other.origin, error: error)
    }
}

private extension CGSize {
    static func uniform(_ side: CGFloat) -> CGSize {
        CGSize(width: side, height: side)
    }

    // MARK: - Equality

    func isAlmostEqual(to other: CGSize) -> Bool {
        width.isAlmostEqual(to: other.width) && height.isAlmostEqual(to: other.height)
    }

    func isAlmostEqual(to other: CGSize, error: CGFloat) -> Bool {
        width.isAlmostEqual(to: other.width, error: error) && height.isAlmostEqual(to: other.height, error: error)
    }
}

private extension BinaryFloatingPoint {
    func isAlmostEqual(to other: Self) -> Bool {
        abs(self - other) < abs(self + other).ulp
    }

    func isAlmostEqual(to other: Self, accuracy: Self) -> Bool {
        abs(self - other) < (abs(self + other) * accuracy).ulp
    }

    func isAlmostEqual(to other: Self, error: Self) -> Bool {
        abs(self - other) <= error
    }
}

public extension CGPoint {
    // MARK: - Equality

    func isAlmostEqual(to other: CGPoint) -> Bool {
        x.isAlmostEqual(to: other.x) && y.isAlmostEqual(to: other.y)
    }

    func isAlmostEqual(to other: CGPoint, error: CGFloat) -> Bool {
        x.isAlmostEqual(to: other.x, error: error) && y.isAlmostEqual(to: other.y, error: error)
    }
}
