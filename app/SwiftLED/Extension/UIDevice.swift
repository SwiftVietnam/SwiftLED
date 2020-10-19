//
//  Copyright © 2020 SwiftVietnam. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.last?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }

    static var topInset: CGFloat {
        return UIApplication.shared.windows.last?.safeAreaInsets.bottom ?? 0.0
    }
}
