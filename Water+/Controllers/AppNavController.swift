//
//  AppNavController.swift
//  Water+
//
//  Created by Илья Кузнецов on 19.09.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class AppNavController: UINavigationController, HalfModalPresentable {

    override var preferredStatusBarStyle: UIStatusBarStyle {
            return isHalfModalMaximized() ? .default : .lightContent
        }

}
