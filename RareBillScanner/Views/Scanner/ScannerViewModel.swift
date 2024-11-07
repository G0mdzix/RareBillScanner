import SwiftUI
import VisionKit
import AestheticKit
import AVFoundation

final class ScannerViewModel: ObservableObject {
  
  @Published var recognizedItems: [RecognizedItem] = []
  @Published var error: Error?
  
  var recognizedDataTypes: Set<DataScannerViewController.RecognizedDataType> = [.text(textContentType: .none)]
  
  var moreButtonItem: [MoreButtonItems] {
    [
      MoreButtonItems(
        primarySFSymbolName: SFSymbols.gear,
        secondarySFSymbolName: SFSymbols.camera,
        action: {}
      ),
      MoreButtonItems(
        primarySFSymbolName: SFSymbols.flashlightOn,
        secondarySFSymbolName: SFSymbols.flashlightOff,
        action: { [weak self] in
          guard let self else { return }
          setTorch()
        }
      )
    ]
  }
  
  var dataScannerViewId: Int {
    var hasher = Hasher()
    hasher.combine("text")
    return hasher.finalize()
  }
  
  private func setTorch() {
    let device: AVCaptureDevice? = {
      if #available(iOS 17, *) {
        AVCaptureDevice.userPreferredCamera
      } else {
        AVCaptureDevice.DiscoverySession(
          deviceTypes: [
            .builtInTripleCamera,
            .builtInDualWideCamera,
            .builtInUltraWideCamera,
            .builtInWideAngleCamera,
            .builtInTrueDepthCamera,
          ],
          mediaType: .video,
          position: .back
        )
        .devices.first
      }
    }()

    guard
      let device = device,
      device.hasTorch,
      device.isTorchAvailable,
      (try? device.lockForConfiguration()) != nil
    else {
      return
    }

    device.torchMode == .on ? device.torchMode = .off : try? device.setTorchModeOn(level: 1.0)
    device.unlockForConfiguration()
  }

}
