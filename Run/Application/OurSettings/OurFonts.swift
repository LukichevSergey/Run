//
//  OurFonts.swift
//  Run
//
//  Created by Лукичев Сергей on 25.08.2023.
//

import UIKit

enum OurFonts {
    static var fontCofficient: CGFloat {
        let coefficient = UIFontMetrics(forTextStyle: .body).scaledFont(for:
                        UIFont(name: "PTSans-Bold", size: 32)!).pointSize / 32
        if coefficient >= 1.5 {
            return 1.5
        } else {
            return coefficient
        }
    }

    static var fontPTSansBold72: UIFont { UIFont(name: "PTSans-Bold", size: 72 * fontCofficient)! }
    static var fontPTSansBold32: UIFont { UIFont(name: "PTSans-Bold", size: 32 * fontCofficient)! }
    static var fontPTSansBold24: UIFont { UIFont(name: "PTSans-Bold", size: 24 * fontCofficient)! }
    static var fontPTSansBold22: UIFont { UIFont(name: "PTSans-Bold", size: 22 * fontCofficient)! }
    static var fontPTSansBold20: UIFont { UIFont(name: "PTSans-Bold", size: 20 * fontCofficient)! }
    static var fontPTSansBold18: UIFont { UIFont(name: "PTSans-Bold", size: 18 * fontCofficient)! }
    static var fontPTSansBold16: UIFont { UIFont(name: "PTSans-Bold", size: 16 * fontCofficient)! }
    static var fontPTSansBold14: UIFont { UIFont(name: "PTSans-Bold", size: 14 * fontCofficient)! }
    static var fontPTSansBold12: UIFont { UIFont(name: "PTSans-Bold", size: 12 * fontCofficient)! }
    static var fontPTSansBold10: UIFont { UIFont(name: "PTSans-Bold", size: 10 * fontCofficient)! }
    static var fontPTSansBold9: UIFont { UIFont(name: "PTSans-Bold", size: 9 * fontCofficient)! }

    static var fontPTSansRegular24: UIFont { UIFont(name: "PTSans-Regular", size: 24 * fontCofficient)! }
    static var fontPTSansRegular22: UIFont { UIFont(name: "PTSans-Regular", size: 22 * fontCofficient)! }
    static var fontPTSansRegular20: UIFont { UIFont(name: "PTSans-Regular", size: 20 * fontCofficient)! }
    static var fontPTSansRegular18: UIFont { UIFont(name: "PTSans-Regular", size: 18 * fontCofficient)! }
    static var fontPTSansRegular16: UIFont { UIFont(name: "PTSans-Regular", size: 16 * fontCofficient)! }
    static var fontPTSansRegular14: UIFont { UIFont(name: "PTSans-Regular", size: 14 * fontCofficient)! }
    static var fontPTSansRegular12: UIFont { UIFont(name: "PTSans-Regular", size: 12 * fontCofficient)! }
    static var fontPTSansRegular11: UIFont { UIFont(name: "PTSans-Regular", size: 11 * fontCofficient)! }
    static var fontPTSansRegular4: UIFont { UIFont(name: "PTSans-Regular", size: 4 * fontCofficient)! }
}
