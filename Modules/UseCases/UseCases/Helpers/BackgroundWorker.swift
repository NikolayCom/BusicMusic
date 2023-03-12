import Foundation

public class BackgroundWorker: NSObject {
    // MARK: - Foreground task

    public func foregroundTask(force: Bool = false, _ request: @escaping Action) {
        if Thread.isMainThread, !force {
            request()
        } else {
            DispatchQueue.main.async(execute: request)
        }
    }

    // MARK: - Background task

    public func backgroundTask(
        queue: DispatchQueue = DispatchQueue.global(qos: .userInitiated),
        _ request: @escaping Action
    ) {
        queue.async {
            request()
        }
    }
}
