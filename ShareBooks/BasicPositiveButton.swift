//
//  BasicPositiveButton.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/10/22.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class BasicPositiveButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = 4
        self.backgroundColor = .positiveColor
        self.setTitleColor(.white, for: .normal)
    }
}
