//
//  EditViewController.swift
//  fbxpollenfallen
//
//  Created by Laurin Fisher on 11/19/17.
//  Copyright © 2017 UAF. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIScrollViewDelegate , UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var editView: UIView! //keep this, it crashes otherwise
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: Variables
    var pollenSources = ["Birch", "Spruce", "Poplar Aspen", "Willow", "Alder", "Other Tree", "Other Tree 2", "Weed", "Mold", "Grass", "Grass 2", "Other", "Other 2"]
    var years = ["2017", "2016", "2015", "2014", "2013"]
    let spacing = 8
    
    //Deinitializer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Notification
    func setupNotification(){
        //Setup an Observer to know when device is rotated
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
  
    //MARK: ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup "Notifications" or Observers
        setupNotification()
        //Draw to the View
        drawLabelsAndSwitches(labels: pollenSources)
        
        //Make the UIScrollView for smaller devices to fit entire content
//        let screensize: CGRect = UIScreen.main.bounds
//        let screenWidth = screensize.width
//        let screenHeight = screensize.height
//        var scrollView = UIScrollView(frame: CGRect(x: 0, y: 120, width: screenWidth, height: screenHeight))
//        scrollView.contentSize = CGSize(width: screenWidth, height: 2000)
//        var Switch = UISwitch(frame: CGRect(x: 150, y: 150, width: 0, height: 0))
//        scrollView.addSubview(Switch)
//        self.view.addSubview(scrollView)
        //scrollView.addSubview(mySwitch)
        //scrollView.delegate = self
    }
    
    //MARK: Draw to the Screen
    func drawLabelsAndSwitches(labels: [String]){
        
        //find largest label to determine how many can fit on screen
        if let max = labels.max(by: {$1.count > $0.count}) {
            //Find the size of a UISwitch
            let mySwitch = UISwitch()
            let SwitchWidth = Int(ceil(mySwitch.frame.size.width))
            let SwitchHeight = Int(ceil(mySwitch.frame.size.height))

            //Calculate the size of the biggest text label
            let newLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            newLabel.text = max
            newLabel.sizeToFit()
            let maxWidth = Int(ceil(newLabel.bounds.size.width))
            
            //calculate width of the horizontal stack of longest
            let longestWidth = maxWidth + spacing + SwitchWidth
 
            //get biggest usable width in view
            let viewWidth = self.view.frame.size.width
            
            //how many of the longest item can we use across the screen
            let itemsAvailablePerViewWidth = Int(ceil(viewWidth))/longestWidth
            print("# of items possible" + String(itemsAvailablePerViewWidth))
//            var newLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
//            newLabel.text = String(itemsAvailablePerViewWidth)
//
            var ySpacing = spacing
            var xSpacing = spacing
            
            //draw labels and draw uiswitches
            for _ in 0..<itemsAvailablePerViewWidth{
                
                //Draw pollen source text
                var Label = UILabel(frame: CGRect(x: xSpacing, y: 150, width: 0, height: 0))
                Label.text = max
                Label.sizeToFit()
                scrollView.addSubview(Label)
                
                //draw corresponding switch
                var Switch = UISwitch(frame: CGRect(x: (xSpacing + longestWidth - SwitchWidth), y: 150 - (SwitchHeight/2), width: 0, height: 0))
                scrollView.addSubview(Switch)
                
                //Spacing between columns
                xSpacing+=spacing + longestWidth //Int(ceil(maxSize.width))
            }
        }
    }
    
    //MARK: Orientation Changes
    //Called when device is rotated, redraw based on new window width
    @objc func rotated(){
        //remove old uiviews & clear the scrollview
        let subViews = scrollView.subviews
        for subview in subViews{
            subview.removeFromSuperview()
        }
        
        var newOrientation = UIDevice.current.orientation
        switch newOrientation{
        case .landscapeLeft, .landscapeRight:
            print("landscape")
            drawLabelsAndSwitches(labels: pollenSources)
        case .portrait, .portraitUpsideDown:
            print("portrait")
            drawLabelsAndSwitches(labels: pollenSources)
        default:
            print("other")
        }
    }

    //MARK: User is Changing Values
    func switchChanged(theSwitch: UISwitch){
        let newValue = theSwitch.isOn
//        if newValue {
//            switch theSwitch.tag{
//            case 1:
//                //birch switch used
//            case 2:
//
//            default:
//            }
//        }
//        else{
//
//        }
    }
    
    //MARK: UIPicker Required functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row] as String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
