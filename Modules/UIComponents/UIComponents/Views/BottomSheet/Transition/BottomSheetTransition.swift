import Foundation

// MARK: - InterBottomSheetTransitionaction

public class BottomSheetTransition: NSObject, UIViewControllerTransitioningDelegate {
    private let driver = TransitionDriver()

    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        self.driver.link(to: presented)

        // Add Driver
        let presentationController = DimmPresentationController(
            presentedViewController: presented,
            presenting: presenting ?? source
        )

        presentationController.driver = self.driver

        return presentationController
    }

    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        PresentAnimation()
    }

    public func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        DismissAnimation()
    }

    // MARK: - Interaction

    public func interactionControllerForPresentation(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        self.driver
    }

    public func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        self.driver
    }
}
