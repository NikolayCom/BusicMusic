import Foundation
import Then

// MARK: - DimmPresentationController

class DimmPresentationController: BottomSheetPresentationController {
    private var cornerRadius: CGFloat = 32

    private lazy var dimmView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.3)
        $0.alpha = .zero
    }

    // MARK: - Override methods

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        self.setupUI()
        self.applyStyle()
        self.setupConstraints()
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)

        guard !completed else { return }
        self.dimmView.removeFromSuperview()
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        self.performAlongsideTransitionIfPossible { [weak self] in
            self?.dimmView.alpha = .zero
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)

        guard completed else { return }
        self.dimmView.removeFromSuperview()
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
    }

    // MARK: - Private methods

    private func setupUI() {
        containerView?.insertSubview(self.dimmView, at: .zero)

        self.performAlongsideTransitionIfPossible { [weak self] in
            self?.dimmView.alpha = 1
        }
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(self.handleTap(_:))
        )
        self.dimmView.addGestureRecognizer(tapGesture)
    }

    private func setupConstraints() {
        guard let containerView = containerView else { return }

        self.dimmView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func performAlongsideTransitionIfPossible(_ block: @escaping () -> Void) {
        guard let coordinator = self.presentedViewController.transitionCoordinator else {
            block()
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            block()
        }, completion: nil)
    }

    private func applyStyle() {
        guard presentedViewController.isViewLoaded else {
            assertionFailure()
            return
        }

        presentedViewController.view.clipsToBounds = true
        presentedViewController.view.layer.cornerRadius = self.cornerRadius
        presentedViewController.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    // MARK: - Actions

    @objc
    func handleTap(_ sender: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
