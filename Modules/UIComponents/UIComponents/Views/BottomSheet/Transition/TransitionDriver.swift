import Foundation

// MARK: - TransitionDriver

class TransitionDriver: UIPercentDrivenInteractiveTransition {
    // MARK: - TransitionDirection

    enum TransitionDirection {
        case present
        case dismiss
    }

    var direction: TransitionDirection = .present

    private var presentedController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer?

    // MARK: - Override

    override var wantsInteractiveStart: Bool {
        get {
            switch self.direction {
            case .present:
                return false

            case .dismiss:
                let gestureIsActive = self.panRecognizer?.state == .began
                return gestureIsActive
            }
        }

        set {}
    }

    func link(to controller: UIViewController) {
        self.presentedController = controller
        self.panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handle(recognizer:)))
        self.presentedController?.view.addGestureRecognizer(self.panRecognizer ?? .init())
    }

    @objc
    private func handle(recognizer: UIPanGestureRecognizer) {
        switch self.direction {
        case .present:
            handlePresentation(recognizer: recognizer)

        case .dismiss:
            handleDismiss(recognizer: recognizer)
        }
    }
}

// MARK: - Gesture Handling

extension TransitionDriver {
    var maxTranslation: CGFloat {
        self.presentedController?.view.frame.height ?? .zero
    }

    /// `pause()` before call `isRunning`
    private var isRunning: Bool {
        percentComplete != .zero
    }

    private func handlePresentation(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            pause()

        case .changed:
            let increment = -recognizer.incrementToBottom(maxTranslation: self.maxTranslation)
            update(percentComplete + increment)

        case .ended, .cancelled:
            guard recognizer.isProjectedToDownHalf(maxTranslation: self.maxTranslation) else {
                finish()
                return
            }
            cancel()

        case .failed:
            cancel()

        default:
            break
        }
    }

    private func handleDismiss(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            pause() // Pause allows to detect isRunning
            guard !self.isRunning else { return }
            self.presentedController?.dismiss(animated: true) // Start the new one

        case .changed:
            update(percentComplete + recognizer.incrementToBottom(maxTranslation: self.maxTranslation))

        case .ended, .cancelled:
            guard recognizer.isProjectedToDownHalf(maxTranslation: self.maxTranslation) else {
                cancel()
                return
            }
            finish()

        case .failed:
            cancel()

        default:
            break
        }
    }
}

private extension UIPanGestureRecognizer {
    func isProjectedToDownHalf(maxTranslation: CGFloat) -> Bool {
        let endLocation = projectedLocation(decelerationRate: .fast)
        let isPresentationCompleted = endLocation.y > maxTranslation.half()

        return isPresentationCompleted
    }

    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).y
        setTranslation(.zero, in: nil)

        return translation / maxTranslation // percent increment
    }
}

private extension UIPanGestureRecognizer {
    func projectedLocation(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        let velocityOffset = velocity(in: view).projectedOffset(decelerationRate: .normal)
        let projectedLocation = location(in: view ?? .init()) + velocityOffset
        return projectedLocation
    }
}

// MARK: - Extension

private extension CGPoint {
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        CGPoint(
            x: x.projectedOffset(decelerationRate: decelerationRate),
            y: y.projectedOffset(decelerationRate: decelerationRate)
        )
    }
}

private extension CGFloat { // Velocity value
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGFloat {
        // Magic formula from WWDC
        let multiplier = 1 / (1 - decelerationRate.rawValue) / 1000
        return self * multiplier
    }
}

private extension CGPoint {
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        CGPoint(
            x: left.x + right.x,
            y: left.y + right.y
        )
    }
}
