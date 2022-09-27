//
//  ViewController.swift
//  SlideSegmentedView
//
//  Created by Alexiusy on 09/27/2022.
//  Copyright (c) 2022 Alexiusy. All rights reserved.
//

import UIKit
import SlideSegmentedView

class ViewController: UIViewController {
    @IBOutlet weak var segmentedView: SlideSegmentedView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        segmentedView.normalColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        segmentedView.selectedColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        segmentedView.startColors = [UIColor(red: 0.15, green: 0.6, blue: 0.4, alpha: 1)]
        segmentedView.endColors = [.orange, .cyan, .blue, .brown, .green, .gray, .black, .darkText, .orange]
        segmentedView.numberOfSegments = 20
        segmentedView.currentIndexChanged = { index in
            print("index \(index) selected")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.segmentedView.setCurrentIndex(3)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

