//
//  MKStatusHudAnimation.swift
//  MKStatusHud
//
//  Created by Mehmed Kadir on 2.11.17.
//

import Foundation
import QuartzCore

public struct MKStatusHudAnimation {
 
     static let discreteRotation: CAAnimation = {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.values = [
            NSNumber(value: 0.0),
            NSNumber(value: 1.0 * .pi / 6.0),
            NSNumber(value: 2.0 * .pi / 6.0),
            NSNumber(value: 3.0 * .pi / 6.0),
            NSNumber(value: 4.0 * .pi / 6.0),
            NSNumber(value: 5.0 * .pi / 6.0),
            NSNumber(value: 6.0 * .pi / 6.0),
            NSNumber(value: 7.0 * .pi / 6.0),
            NSNumber(value: 8.0 * .pi / 6.0),
            NSNumber(value: 9.0 * .pi / 6.0),
            NSNumber(value: 10.0 * .pi / 6.0),
            NSNumber(value: 11.0 * .pi / 6.0),
            NSNumber(value: 2.0 * .pi)
        ]
        animation.keyTimes = [
            NSNumber(value: 0.0),
            NSNumber(value: 1.0 / 12.0),
            NSNumber(value: 2.0 / 12.0),
            NSNumber(value: 3.0 / 12.0),
            NSNumber(value: 4.0 / 12.0),
            NSNumber(value: 5.0 / 12.0),
            NSNumber(value: 0.5),
            NSNumber(value: 7.0 / 12.0),
            NSNumber(value: 8.0 / 12.0),
            NSNumber(value: 9.0 / 12.0),
            NSNumber(value: 10.0 / 12.0),
            NSNumber(value: 11.0 / 12.0),
            NSNumber(value: 1.0)
        ]
        animation.duration = 1.2
        animation.calculationMode = "discrete"
        animation.repeatCount = Float(INT_MAX)
        return animation
    }()
    
    
}
