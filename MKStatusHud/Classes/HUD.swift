//
//  HUD.swift
//  MKStatusHud
//
//  Created by Mehmed Kadir on 31.10.17.
//
import Lottie

public enum Animation {
    case backwards
    case forward
    case none
}

open class HUD {
    
    var container:MKStatusHudView!
    var progressTime:((Double)->Void)? = nil
    var progress:Double = 0
    var mDispatchWorkItem: DispatchWorkItem?
    var timer:Timer?
    
    var internal_completion:((Bool) -> Void)? = nil
    var animationCompletion:((Bool) -> Void)? = nil
    
    var image:UIImage?
    var title:String?
    var subtitle:String?
    
    /**
     init with image
     */
    public init(withImage image:UIImage? = nil,title:String? = nil,subtitle:String? = nil){
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
    
    public var presentOnView:UIView?
    public var rotation:Bool = false
    
    public func show(begin:((Bool)->Void)? = nil,progress:((Double)->Void)? = nil,animation withCompletion:((Bool)->Void)? = nil,completion: ((Bool) -> Void)? = nil)  {
        let view: UIView = presentOnView  ?? UIApplication.shared.keyWindow!
        internal_completion = completion
        animationCompletion = withCompletion
        if let previusView = container {
            previusView.removeFromSuperview()
        }
        container = MKStatusHudView()
        container.statusImage.image = image
        container.title.text = title
        container.subtitle.text = subtitle
        view.addSubview(container)
        
      //ADD constraints
        self.container.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = NSLayoutConstraint(item: container, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: container, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 230)
        let heightConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 230)
       
        DispatchQueue.main.async {
            view.addConstraints([centerXConstraint, centerYConstraint, widthConstraint, heightConstraint])
            view.layoutIfNeeded()
        }
        
        
        if rotation {
            container.startAnimation(animation: MKStatusHudAnimation.discreteRotation)
        }
        container.frame = CGRect(x: 0, y: 0, width: 230, height: 230)

        keepProgress(progress: progress)
        
        container.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: { [weak self] in
            self?.container?.alpha = 1.0
            self?.container?.transform = CGAffineTransform.identity
        })
        prepareAnimation(animationCompletion)
        begin?(true)
    }
    /**
     Update hud in runtime
     @param rotation defoult is false , if true starts rotation animation on actual hud imageView
     @param dismiss   closes the hud after given time if set nill hud should be closed manualy with
     calling hud.close() function
     */
    public func update(withImage image:UIImage?,title:String?,subtitle:String?,rotation:Bool? = false,dismiss delay:Double? = nil) {
        if image != nil {
            container.statusImage.image = image
            anime?.removeFromSuperview()
        }
        updateWith(title: title, subtitle: subtitle)
        if rotation != nil && !rotation! {
            container.stopAnimation()
        } else {
            container.startAnimation(animation: MKStatusHudAnimation.discreteRotation)
        }
        if let delay = delay {
        close(hideAfter: delay)
        }
    }
    
    var anime:LOTAnimationView?
    /**
     Predefined Optional
     */
    public var animationScale = CGAffineTransform(scaleX: 1, y: 1)
    /**
     Predefined Optional
     */
    public var animationLoop = false
    /**
     Predefined Optional
     */
    public var animateToProgress:CGFloat = 1
    /**
     Predefined Optional
     */
    private var animationFromProgres:CGFloat = 0
    public var animateFromProgresPlus:CGFloat = 0
    /**
     init with animation
     */
    public  init(withAnimation animation:LOTAnimationView?,title:String?,subtitle:String?) {
        self.title = title
        self.subtitle = subtitle
        self.anime = animation ?? LOTAnimationView(name: "loading", bundle: Bundle(identifier: "org.cocoapods.MKAnimationHud")!)
    }
    
    internal func prepareAnimation(_ animationCompletion:((Bool)->Void)? = nil) {
        if let animation = anime {
            animation.pause()
            container.statusImage.image = nil
            if  !container.statusImage.subviews.contains(animation) {
                container.statusImage.addSubview(animation)
            }
            animation.frame = container.statusImage.bounds
            animation.center = container.statusImage.center
            animation.contentMode = .scaleAspectFit
            animation.transform = animationScale
            
            animation.loopAnimation = animationLoop
            animation.play(fromProgress: animationFromProgres+animateFromProgresPlus, toProgress: animateToProgress, withCompletion: {(completed) in
                animationCompletion?(completed)
            })
            
        }
    }
    /**
     Update hud in runtime
     @param animation  is Lottie animaiton, updates hud with given animation
     @param rotation defoult is false , if true starts rotation animation on actual hud imageView
     @param closeTime   closes the hud after given time if set nill hud should be closed manualy with
     calling hud.close() function
     */
    public func update(withAnimation animation:LOTAnimationView?,title:String?,subtitle:String?,rotation:Bool? = false,closeTime:Double? = nil) {
        if animation != nil {
            anime?.removeFromSuperview()
            anime = animation
        }else {
            if anime != nil && anime!.isAnimationPlaying {
                animationFromProgres = anime!.animationProgress
            }
        }
        prepareAnimation(animationCompletion)
        container.statusImage.image = nil
        updateWith(title: title, subtitle: subtitle)
        if rotation != nil && !rotation! {
            container.stopAnimation()
        } else {
            container.startAnimation(animation: MKStatusHudAnimation.discreteRotation)
        }
        if let closeTime = closeTime {
        close(hideAfter: closeTime)
        }
    }
    
    public func updateWith(title:String?,subtitle:String?) {
        container.title.text = title
        container.subtitle.text = subtitle
    }
    
    fileprivate func keepProgress(progress:((Double)->Void)? = nil) {
        timer?.invalidate()
        
        progressTime = progress
        self.progress = 0
        timer =  Timer.scheduledTimer(timeInterval: 0.5,
                                      target: self,
                                      selector: #selector(finish(_:)),
                                      userInfo: nil,
                                      repeats: true)
        
    }
    
    @objc func finish(_ timer: Timer? = nil) {
        progress = progress + 0.5
        progressTime?(progress)
    }
    
    public func close(hideAfter interval:TimeInterval = 0) {
        
        mDispatchWorkItem?.cancel()
        mDispatchWorkItem = DispatchWorkItem { [weak self] in
            self?.removeSelf(completion: self?.internal_completion)
        }
        
        if mDispatchWorkItem != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: mDispatchWorkItem!)
        }
    }
    // MARK: WorkItem callback
    func removeSelf(completion: ((Bool) -> Void)? = nil) {
        
        // Animate removal of view
        UIView.animate(withDuration: 0.15, animations: { [weak self] in
            self?.container.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self?.container.alpha = 0.0
        }) { [weak self] isComplited  in
            completion?(isComplited)
            self?.internal_completion = nil
            self?.animationCompletion = nil
            self?.container.removeFromSuperview()
            self?.timer?.invalidate()
            self?.progressTime = nil
            self?.anime?.stop()
            self?.anime?.removeFromSuperview()
        }
    }
}
