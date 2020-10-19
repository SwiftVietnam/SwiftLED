//
//  Copyright © 2020 SwiftVietnam. All rights reserved.
//

import UIKit

extension UIView {

    func roundCorners(to radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
