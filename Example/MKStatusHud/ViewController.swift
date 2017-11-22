//
//  ViewController.swift
//  MKStatusHud
//
//  Created by Mehmed Kadir on 11/08/2017.
//  Copyright (c) 2017 Mehmed Kadir. All rights reserved.
//

import UIKit
import MKStatusHud
import Lottie

class ViewController: UIViewController {
    
    @IBOutlet weak var vv: UIView!
    @IBAction func buttonPressed(_ sender: Any) {
        let hud = HUD(withImage: #imageLiteral(resourceName: "download"), title: "Please wait!", subtitle: "While download proccess completes.")
        hud.rotation = true
        hud.presentOnView = self.view
        hud.show(begin: {(isStarted) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                hud.update(withImage: #imageLiteral(resourceName: "download"), title: "Done!", subtitle: "Download completed.",rotation: false,dismiss:10)
            })
        }) { (finished) in
            print(finished)
        }
    }
    
    @IBAction func completeAnimeWithSuccess(_ sender: UIButton) {
        //Create the hud
        let hud = HUD(withAnimation: LOTAnimationView(name: "loader-success-failed"), title: "Please wait!", subtitle: "While download proccess completes.")
        hud.animateToProgress = 0.275
        hud.animationLoop = true
        hud.presentOnView = self.view

        //Present the hud
        hud.show(begin: { (isStarted) in
            //...//
            // Some time lataer when download finished succesfully
            //...//
            self.succesFinish(hud)
            //Optional completion for progress time
        }, progress: { (progress) in
            //Optional completion for animation finish
        }, animation: { (isFinished) in
            if isFinished {
                hud.updateWith(title: "Done!", subtitle: "Process completed.")
                hud.close(hideAfter: 2)
            }
            //Optional completion for hud dismissal
        }, completion: { (completed) in
            print("hud dissmissed - > \(completed)")
        })
    }
    
    @IBAction func completeAnimeWithError(_ sender: UIButton) {
        let hud = HUD(withAnimation: LOTAnimationView(name: "loader-success-failed"), title: "Please wait!", subtitle: "While download proccess completes.")
        hud.animateToProgress = 0.275
        hud.animationLoop = true
        hud.presentOnView = self.view

        hud.show(begin: { (isStarted) in
            self.errorFinish(hud)
        }, progress: { (progress) in
        }, animation: { (isFinished) in
            if isFinished {
                hud.updateWith(title: "Sorry!", subtitle: "Try again later.")
                hud.close(hideAfter: 2)
            }
        }, completion: { (completed) in
            print("hud dissmissed - > \(completed)")
        })
    }
    
    @IBAction func loadingAction(_ sender: Any) {
        let hud = HUD(withAnimation: LOTAnimationView(name: "dna_like_loader"), title: "Please wait!", subtitle: "While download proccess completes.")
        hud.animationLoop = true
        hud.presentOnView = self.view
        
        hud.show(begin: { (isStarted) in
            //Some time later close the hud
            hud.close(hideAfter: 10)
            
        }, progress: { (progress) in
        }, animation: { (isFinished) in
        }, completion: { (completed) in
            print("hud dissmissed - > \(completed)")
        })
        
    }
    
    
    private func succesFinish(_ hud:HUD) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            hud.animateToProgress = 0.47
            hud.animationLoop = false
            hud.update(withAnimation: nil, title: "Finishing up", subtitle: "Will be ready in a second.")
        })
    }
    
    private func errorFinish(_ hud:HUD) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            hud.animateFromProgresPlus = 0.5
            hud.animateToProgress = 0.95
            hud.animationLoop = false
            hud.update(withAnimation: nil, title: "It semms like", subtitle: "Taking to much time.")
        })
    }
}

