//
//  UIFont+Extension.swift
//  Max
//
//  Created by Ankit on 20/01/22.
//

import Foundation
import UIKit

extension UIFont {
    static func proximaNovaBold(of size: CGFloat) -> UIFont {
     return UIFont(name: "ProximaNova-Bold", size: size)!
    }

    static func proximaNovaLight(of size: CGFloat) -> UIFont {
     return UIFont(name: "ProximaNova-Light", size: size)!
    }

    static func proximaNovaLightItalic(of size: CGFloat) -> UIFont {
     return UIFont(name: "ProximaNova-LightIt", size: size)!
    }

    static func proximaNovaRegular(of size: CGFloat) -> UIFont {
     return UIFont(name: "ProximaNova-Regular", size: size)!
    }

    static func proximaNovaSemiBold(of size: CGFloat) -> UIFont {
     return UIFont(name: "ProximaNova-Semibold", size: size)!
    }
}
