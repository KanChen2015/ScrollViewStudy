//
//  ScrollViewContainer.swift
//  ScrollViewTest
//
//  Created by Kan Chen on 12/24/15.
//  Copyright © 2015 Kan Chen. All rights reserved.
//

import UIKit

class ScrollViewContainer: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, withEvent: event)

        if let theView = view {
            if theView == self {
                return scrollView
            }
        }
        return view
    }

}
