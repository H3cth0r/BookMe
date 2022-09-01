//
//  GeneralMethods.swift
//  BookMe
//
//  Created by Héctor Miranda García on 31/08/22.
//

import Foundation
import UIKit

extension UIView{
    func fadeOut(){
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: nil)
    }
    
    func fadeIn(){
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.alpha = 1.0
            }, completion: nil)
    }
}
