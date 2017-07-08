//
//  BMCustomPlayer.swift
//  ipad
//
//  Created by 李源 on 08/07/2017.
//  Copyright © 2017 李源. All rights reserved.
//

import UIKit
import BMPlayer

class BMCustomPlayer: BMPlayer {
    class override func storyBoardCustomControl() -> BMPlayerControlView? {
        return BMPlayerCustomControlView()
    }
}
