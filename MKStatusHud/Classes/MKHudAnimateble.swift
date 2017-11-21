//
//  MKHudAnimateble.swift
//  MKStatusHud
//
//  Created by Mehmed Kadir on 2.11.17.
//

@objc protocol MKHudAnimatable {
   @objc optional func startAnimation()
   @objc optional func stopAnimation()
}
