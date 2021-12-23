//
//  DotDotSlider.swift
//  DotDotSlider
//
//  Created by SpotCam-MBP-01 on 2021/11/23.
//

import UIKit
@objc (DotDotSliderDelegate)
protocol DotDotSliderDelegate{
    func DotDotSlider_change_value_to(multiple:Float)
}

public let padding_view_thumd:CGFloat = 5

@objc class DotDotSlider: UIView {
    var lb_multiple_1x:UILabel! = nil
    var lb_multiple_8x:UILabel! = nil
    public var value_max:Float? = nil
    public var value_min:Float? = nil
    public var color_major:UIColor? = nil
    public var color_minor:UIColor? = nil
    @objc public weak var delegate:DotDotSliderDelegate?
    @IBOutlet weak var bottom_thumb_to_bottom: NSLayoutConstraint!
    @IBOutlet weak var lb_thumb: UILabel!
    @objc func initUI(multiple:Float, width_ui:Float){
        let m_color_major:UIColor = color_major ?? UIColor.blue
        let m_color_minor:UIColor = color_minor ?? UIColor.white
        lb_multiple_1x = UILabel()
        lb_multiple_1x.frame = CGRect.init(x: padding_view_thumd, y: self.frame.size.height - self.frame.size.width + padding_view_thumd, width: self.frame.size.width - padding_view_thumd*2, height: self.frame.size.width - padding_view_thumd*2)
        lb_multiple_1x.text = String(format: "%.0fX", value_min ?? 1)
        lb_multiple_1x.textAlignment = .center
        lb_multiple_1x.textColor = m_color_minor
        self.addSubview(lb_multiple_1x)
        lb_multiple_8x = UILabel()
        lb_multiple_8x.frame = CGRect.init(x: padding_view_thumd, y: padding_view_thumd, width: self.frame.size.width - padding_view_thumd*2, height: self.frame.size.width - padding_view_thumd*2)
        lb_multiple_8x.text = String(format: "%.0fX", value_max ?? 8)
        lb_multiple_8x.textAlignment = .center
        lb_multiple_8x.textColor = m_color_minor
        self.addSubview(lb_multiple_8x)
        self.lb_thumb.isUserInteractionEnabled = true
        self.sendSubviewToBack(lb_multiple_1x)
        self.sendSubviewToBack(lb_multiple_8x)
        
        self.lb_thumb.textColor = m_color_major
        self.lb_thumb.backgroundColor = UIColor.clear
        self.lb_thumb.layer.cornerRadius = CGFloat(width_ui/2) - padding_view_thumd
        self.lb_thumb.layer.borderColor = m_color_major.cgColor
        self.lb_thumb.layer.borderWidth = 1
        
        for i in stride(from: 1, to: 7, by: 1) {
            let dotView:UIView = UIView()
            let y_lb_multiple_8x:Float = Float(self.lb_multiple_8x.frame.origin.y)
            let y_lb_multiple_1x:Float = Float(self.lb_multiple_1x.frame.origin.y)
            let width_lb_multiple_8x:Float = Float(self.lb_multiple_8x.frame.size.width)
            let num_1:Float = ((value_max ?? 8) - (value_min ?? 1))
            let num_2:Float = y_lb_multiple_8x + width_lb_multiple_8x/2
            let num_y:Float = num_2 + ((y_lb_multiple_1x - y_lb_multiple_8x)/num_1) * Float(i)
            dotView.frame = CGRect(x: self.frame.size.width/2, y:CGFloat(num_y)  , width: 2, height: 2)
//            NSLog("[] num_2:%f", num_2)
//            NSLog("(value_max ?? 8) - (value_min ?? 1) %f", (value_max ?? 8) - (value_min ?? 1))
//            NSLog("[] num_y_%d:%f", i, num_y)
            dotView.layer.cornerRadius = 1
            dotView.backgroundColor = m_color_minor
            self.addSubview(dotView)
        }
    }
    
    @IBAction func pan_on_value_change(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: self)
//        NSLog("[DotDotSlider] pan_on_value_change:%f",point.y)
        var distance_move:Float = Float(-(self.frame.self.height - point.y) + self.lb_thumb.frame.size.width/2 + padding_view_thumd)
        let disstance_all:Float = Float(self.frame.self.height - self.lb_thumb.frame.size.width - padding_view_thumd*2)
        
        
//        if distance_move <= 0 - Float(padding_view_thumd) && distance_move >= Float(-(self.frame.self.height - self.lb_thumb.frame.self.width - padding_view_thumd)){
//            NSLog("[DotDotSlider] disstance_all:%f",disstance_all)
//            NSLog("[DotDotSlider] distance_move:%f",distance_move)
//            bottom_thumb_to_bottom.constant = CGFloat(distance_move)
////            self.lb_thumb.text = String((distance_move/disstance_all)*(value_max - value_min) + value_min)
//            self.lb_thumb.text = String(format: "%.1f", -1*(distance_move/disstance_all)*(value_max - value_min) + value_min)
//        }
        if distance_move > 0 - Float(padding_view_thumd){
            distance_move = 0 - Float(padding_view_thumd)
        }
        if distance_move < -1*disstance_all - Float(padding_view_thumd)
        {
            distance_move = -1*disstance_all - Float(padding_view_thumd)
        }
        
//        NSLog("[DotDotSlider] disstance_all:%f",disstance_all)
//        NSLog("[DotDotSlider] distance_move:%f",distance_move)
        bottom_thumb_to_bottom.constant = CGFloat(distance_move)
//            self.lb_thumb.text = String((distance_move/disstance_all)*(value_max - value_min) + value_min)
        let num:Float = (distance_move + Float(padding_view_thumd));
        let num2:Float = ((value_max ?? 8) - (value_min ?? 1));
        let num_multiple:Float = -1*(num/disstance_all) * num2 + (value_min ?? 1)
        self.lb_thumb.text = String(format: "%.1fX", num_multiple)
        self.delegate?.DotDotSlider_change_value_to(multiple: num_multiple)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
