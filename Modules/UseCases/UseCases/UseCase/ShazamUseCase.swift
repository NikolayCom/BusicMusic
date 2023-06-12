import Core
import ShazamKit
import AVKit
import Models

// MARK: ShazamUseCase

public protocol ShazamUseCase {
    func startListening(completion: @escaping UICompletionResult<ShazamMedia>)
}

// MARK: ShazamUseCaseImpl

@available(iOS 15.0, *)
public class ShazamUseCaseImpl: NSObject, BaseUseCase {
    private let audioEngine = AVAudioEngine()
    private let session = SHSession()
    private let signatureGenerator = SHSignatureGenerator()

    // private let audioSession = AVAudioSession.sharedInstance()

    private var completion: UICompletionResult<ShazamMedia>?

    override init() {
        super.init()

        session.delegate = self
    }
}

// MARK: ShazamUseCase

@available(iOS 15.0, *)
extension ShazamUseCaseImpl: ShazamUseCase {
    public func startListening(completion: @escaping UICompletionResult<Models.ShazamMedia>) {
        self.completion = completion

        let audioSession = AVAudioSession.sharedInstance()
        audioSession.requestRecordPermission { granted in
            guard granted else { return }

            try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)

            let inputNode = self.audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: .zero)

            inputNode.installTap(
                onBus: .zero,
                bufferSize: 1024,
                format: recordingFormat
            ) { (buffer: AVAudioPCMBuffer, _) in
                self.session.matchStreamingBuffer(buffer, at: nil)
            }

            self.audioEngine.prepare()
            do {
                try self.audioEngine.start()
            } catch let error as NSError {
                assertionFailure(error.localizedDescription)
            }

            DispatchQueue.main.async {
                // self.isRecording = true
            }
        }
    }
}

// MARK: SHSessionDelegate

@available(iOS 15.0, *)
extension ShazamUseCaseImpl: SHSessionDelegate {
    public func session(_ session: SHSession, didFind match: SHMatch) {
        if let firstItem = match.mediaItems.first {
            let media = ShazamMedia(
                title: firstItem.title,
                subtitle: firstItem.subtitle,
                artistName: firstItem.artist,
                albumArtURL: firstItem.artworkURL,
                genres: firstItem.genres
            )
            self.completion?(.value(media))
            self.completion = nil
        }
    }

    public func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        if let error {
            completion?(.error(.auth))
        }
    }
}
