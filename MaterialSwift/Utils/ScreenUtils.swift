//
//  ScreenUtils.swift
//  MaterialSwift
//
//  Created by 임준협 on 4/7/24.
//

import Foundation
import UIScreenExtension
import UIKit

func ppi() -> CGFloat {
    if let pointsPerCentimeter = UIScreen.pointsPerCentimeter {
       return pointsPerCentimeter
    } else {
        return 0
    }
}
