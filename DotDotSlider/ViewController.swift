//
//  ViewController.swift
//  DotDotSlider
//
//  Created by SpotCam-MBP-01 on 2021/11/23.
//

import UIKit

class ViewController: UIViewController, DotDotSliderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let nib = Bundle.main.loadNibNamed("DotDotSlider", owner: self),
               let nibView = nib.first as? DotDotSlider {
            nibView.frame = CGRect(x: 0, y: 100, width:40, height: 200)
                 nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                 view.addSubview(nibView)
            nibView.value_max = 8
            nibView.value_min = 1
            nibView.delegate = self
            nibView.initUI(multiple: 0, width_ui: 40);
        }
    }
    
    func DotDotSlider_change_value_to(multiple: Float) {
        NSLog("DotDotSlider_change_value_to:%f", multiple)
    }


}

