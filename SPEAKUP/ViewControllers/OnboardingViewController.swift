//
//  OnboardingViewController.swift
//  SPEAKFUCKINGAPP
//
//  Created by Alexey Antonov on 25/11/2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
       var slides:[Slide] = [];
     
     override func viewDidLoad() {
         super.viewDidLoad()
        
        scrollView.delegate = self
        
         slides = createSlides()
         setupSlideScrollView(slides: slides)
         
         pageControl.numberOfPages = slides.count
         pageControl.currentPage = 0
         view.bringSubviewToFront(pageControl)
     }
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
     func createSlides() -> [Slide] {
         
         let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
         slide1.imageView.image = UIImage(named: "onboarding1")
         slide1.labelTitle.text = "Ready to talk?"
         slide1.labelDesc.text = "You will have a conversation with the other players. You can decide how long your conversation will last! But you will also be given a secret, individual task. Do not show it to the other players..."
         
         let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
         slide2.imageView.image = UIImage(named: "onboarding2")
         slide2.labelTitle.text = "The goal of the game"
         slide2.labelDesc.text = "is to complete the task you have been assigned within the given time. But careful! Do not let the other players guess what your task is, or you will lose!"
         
         let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
         slide3.imageView.image = UIImage(named: "onboarding3")
         slide3.labelTitle.text = ""
         slide3.labelDesc.text = "Find a creative way to shift the focus of the conversation and achieve your goal without being discovered. Be subtle, be wise, use strategy… and most importantly, speak app!"
         
         return [slide1, slide2, slide3]
     }
     func setupSlideScrollView(slides : [Slide]) {
         scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
         scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
         scrollView.isPagingEnabled = true
         
         for i in 0 ..< slides.count {
             slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
             scrollView.addSubview(slides[i])
         }
     }
     
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           
    var pageIndex = round(scrollView.contentOffset.x / view.frame.width)
    pageControl.currentPage = Int(pageIndex)
    
            let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
           let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
           
           let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
           let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
           
           let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
           let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
           
           let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
           
           if(percentOffset.x > 0 && percentOffset.x <= 0.50) {
               slides[0].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.50, y: (0.50-percentOffset.x)/0.50)
               slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
           } else if(percentOffset.x > 0.50 && percentOffset.x <= 1) {
               slides[1].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.50, y: (1-percentOffset.x)/0.50)
               slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/1, y: percentOffset.x/1)
           }
       }
}
