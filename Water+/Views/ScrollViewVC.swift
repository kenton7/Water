//
//  ScrollViewVC.swift
//  Water+
//
//  Created by Илья Кузнецов on 11.09.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class ScrollViewVC: UIScrollView {
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        bounds.origin.y = bounds.origin.y - translation.y
        
        recognizer.setTranslation(CGPoint.zero, in: self)
    }
}
