import SwiftUI

class Model: ObservableObject {
    @Published var orientation: UIDeviceOrientation = UIDeviceOrientation.unknown
    @Published var orientationText  = "unknown"
    
    init() {
        Task(priority: .background) {
            await listenForOrientationChanges()
        }
    }
    
    @MainActor
    func listenForOrientationChanges() async {
        let center = NotificationCenter.default
        let named = UIDevice.orientationDidChangeNotification
        for await _ in center.notifications(named: named, object: nil) {
            let device = UIDevice.current
            orientation = device.orientation
            orientationText = text(of: orientation)
        }
    }
    
    func text(of: UIDeviceOrientation) -> String {
        switch orientation {
        case .faceDown:
            return "face down"
        case .faceUp:
            return "face up"
        case .portrait:
            return "portrait"
        case .portraitUpsideDown:
            return "portrait upside-down"
        case .landscapeLeft:
            return "landscape left"
        case .landscapeRight:
            return "landscape right"
        case .unknown:
            return "unknown"
        @unknown default:
            return "unhandled"
        }
    }
}
