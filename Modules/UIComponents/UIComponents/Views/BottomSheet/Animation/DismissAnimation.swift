import Foundation

// MARK: - DismissAnimation

class DismissAnimation: NSObject {
    let duration: TimeInterval = 0.3

    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let from = transitionContext.view(forKey: .from) ?? .init()
        let initialFrame = transitionContext.initialFrame(
            for: transitionContext.viewController(forKey: .from) ?? .init()
        )

        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            from.frame = initialFrame.offsetBy(dx: .zero, dy: initialFrame.height)
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
}

// MARK: - DismissAnimation

extension DismissAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        self.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.animator(using: transitionContext).startAnimation()
    }

    func interruptibleAnimator(
        using transitionContext: UIViewControllerContextTransitioning
    ) -> UIViewImplicitlyAnimating {
        self.animator(using: transitionContext)
    }
}
