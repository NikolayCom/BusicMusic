import Foundation

// MARK: - PresentAnimation

class PresentAnimation: NSObject {
    let duration: TimeInterval = 0.3

    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // transitionContext.view contains needed info, get it
        let trInfo = transitionContext.view(forKey: .to) ?? .init()

        // Final frame from BottomSheetPresentationController
        let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .from) ?? .init())

        // Move Controller outside Screen
        trInfo.frame = finalFrame.offsetBy(dx: .zero, dy: finalFrame.height)
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            trInfo.frame = finalFrame // Moving to his place
        }

        animator.addCompletion { _ in
            // Complete moving transition if dont stopped
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
}

// MARK: - PresentAnimation

extension PresentAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
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
