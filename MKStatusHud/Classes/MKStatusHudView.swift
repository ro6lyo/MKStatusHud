//
//  MKStatusHudView.swift
//  MKStatusHud
//
//  Created by Mehmed Kadir on 31.10.17.
//

import UIKit

public class MKStatusHudView:UIView {
    // Set Up View
    @IBOutlet var content: UIVisualEffectView!
   
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet  weak var statusImage: UIImageView!
    @IBOutlet  weak var title: UILabel!
    @IBOutlet  weak var subtitle: UILabel!
    
    
    public override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        setUpView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.content.layer.masksToBounds = true
        self.content.clipsToBounds = true
        self.content.layer.cornerRadius = 10
    }
    
    func setUpView() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("MKStatusHudView", owner: self, options: nil)
        addSubview(content)
        content.frame = bounds
        content.autoresizingMask = [ .flexibleWidth,
                                        .flexibleHeight]
        content.isUserInteractionEnabled = false
        isUserInteractionEnabled = false
    }
    
    internal func startAnimation(animation:CAAnimation?) {
        if let anime = animation {
            
            if let keys = statusImage.layer.animationKeys() {
                if !keys.contains("test") {
                    statusImage.layer.add(anime, forKey: "test")
                }
            } else {
                statusImage.layer.add(anime, forKey: "test")
            }
        }
    }
    
    public func stopAnimation() {
        statusImage.layer.removeAnimation(forKey: "test")
    }
    
    public override func didMoveToSuperview() {
        if title.text == "" && subtitle.text == "" {
            UIView.animate(withDuration: 0) { [weak self] in
                self?.stackView.isHidden = true
            }
        }
    }
}
