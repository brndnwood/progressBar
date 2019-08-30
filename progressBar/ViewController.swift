//
//  ViewController.swift
//  progressBar
//
//  Created by Brandon Wood on 8/26/19.
//  Copyright © 2019 Brandon Wood. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var progressBar1View: UIView!
    @IBOutlet weak var progressBar2View: UIView!
    @IBOutlet weak var progressBar3View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let progressBar1 = ProgressBarView(animated: false, width: progressBar1View.frame.width, height: progressBar1View.frame.height, percent: 0.5)
        
        let progressBar2 = ProgressBarView(animated: true, width: progressBar2View.frame.width, height: progressBar2View.frame.height, percent: 1)
      
        let progressBar3 = ProgressBarView(animated: false, width: progressBar3View.frame.width, height: progressBar3View.frame.height, percent: 0.25)
        
        // add shape layer to view
        progressBar1View.addSubview(progressBar1)
        progressBar2View.addSubview(progressBar2)
        progressBar3View.addSubview(progressBar3)


    }


    

}

