import Alamofire
import Foundation
import LivenessSDK

@objc(FaceoffLivenessPlugin)

public class FaceoffLivenessPlugin: CDVPlugin {
    var command: CDVInvokedUrlCommand?

    @objc func checkLiveness(_ command: CDVInvokedUrlCommand) {
        let nicFrontBase64Image = command.arguments[safe: 0] as? String ?? ""
        let nicBackBase64Image = command.arguments[safe: 1] as? String ?? ""
        let setChallengeMoveYourFaceToRight = command.arguments[safe: 2] as? Bool ?? true
        let setChallengeMoveYourFaceToLeft = command.arguments[safe: 3] as? Bool ?? true
        let setChallengeNodYourHead = command.arguments[safe: 4] as? Bool ?? true
        let isFaceComparisonRequired = command.arguments[safe: 5] as? Bool ?? true
        let isOcrRequired = command.arguments[safe: 6] as? Bool ?? true
        let maxNumberOfChallenges = command.arguments[safe: 7] as? Int ?? 3
        self.command = command

        let livenessConfig = LivenessConfig(
            setChallengeMoveYourFaceToRight: setChallengeMoveYourFaceToRight,
            setChallengeMoveYourFaceToLeft: setChallengeMoveYourFaceToLeft,
            setChallengeNodYourHead: setChallengeNodYourHead,
            maxNumberOfChallenges: maxNumberOfChallenges,
            isOcrRequired: isOcrRequired,
            isFaceComparisonRequired: isFaceComparisonRequired,
            nicFrontImageInBase64: nicFrontBase64Image,
            nicBackImageBase64: nicBackBase64Image)

        let vc = LaunchLivenessViewController(nibName: "LaunchLivenessViewController", bundle: Bundle(identifier: "com.unikrew.faceoff.LivenessSDK"))
        vc.livenessConfig = livenessConfig
        vc.livenessResponseDelegate = self

        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            rootVC.present(vc, animated: true, completion: nil)
        }
    }
}

extension FaceoffLivenessPlugin: LivenessResponseDelegate {
    public func onLivenessComplete(livenessResponse: LivenessResponse) {
        let jsonEncoder = JSONEncoder()

        do {
            let jsonData = try jsonEncoder.encode(livenessResponse)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: json)
            self.commandDelegate.send(pluginResult, callbackId: self.command?.callbackId)
        } catch {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Something went wrong")
            self.commandDelegate.send(pluginResult, callbackId: self.command?.callbackId)
        }
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        index >= 0 && index < count ? self[index] : nil
    }
}
