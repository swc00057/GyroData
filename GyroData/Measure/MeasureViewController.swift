//
//  MeasureViewController.swift
//  GyroData
//
//  Created by 김지인 on 2022/09/21.
//

import UIKit

class MeasureViewController: UIViewController {
    
    let mainView = MeasureView()
    weak var timer: Timer?
    var graphView: GraphView!
    let stepDuration = 0.1
    var aData: CGFloat = 0.0
    var bData: CGFloat = 0.0
    var cData: CGFloat = 0.0
    var aBuffer = GraphBuffer(count: 100)
    var bBuffer = GraphBuffer(count: 100)
    var cBuffer = GraphBuffer(count: 100)
    var countDown = 0
    
    override func loadView() {
        self.view = mainView
        self.navigationItem.title = "측정하기"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        graphView = mainView.lineChartView as? GraphView
        graphView.aPoint = aBuffer
        graphView.bPoint = bBuffer
        graphView.cPoint = cBuffer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    func setup() {
        mainView.segmentControl.selectedSegmentIndex = 0
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "측정", style: .plain, target: self, action: #selector(saveAction))
        mainView.measureButton.addTarget(self, action: #selector(measureButtonClicked), for: .touchUpInside)
        mainView.stopButton.addTarget(self, action: #selector(stopButtonClicked), for: .touchUpInside)
        //MARK: TEST CODE4
//        mainView.testButton.addTarget(self, action: #selector(testButtonClicked), for: .touchUpInside)
    }
    
    // MARK: incomplete
    @objc func saveAction() {
        print("저장")
    }
    
    @objc func measureButtonClicked() {
        
        print("측정")
        mainView.measureButton.isEnabled = false
        countDown = 600 //max 60초
        timer = Timer.scheduledTimer(withTimeInterval: stepDuration
                                     , repeats: true) { [weak self] (timer) in
            guard let self = self else { return }
            self.aData = CGFloat.random(in: self.graphView.minValue * 0.75...self.graphView.maxValue * 0.75)
            self.bData = CGFloat.random(in: self.graphView.minValue * 0.75...self.graphView.maxValue * 0.75)
            self.cData = CGFloat.random(in: self.graphView.minValue * 0.75...self.graphView.maxValue * 0.75)
            self.graphView.animateNewValue(aValue: self.aData, bValue: self.bData, cValue: self.cData, duration: self.stepDuration)
            self.countDown -= 1
            if self.countDown <= 0 {
                timer.invalidate()
            }
        }
        
    }
    @objc func stopButtonClicked() {
        timer?.invalidate()
        self.graphView.reset()
        mainView.measureButton.isEnabled = true
    }
    
    
//    // MARK: TEST CODE3
//    @objc func testButtonClicked() {
//        self.sensorData = CGFloat.random(in: self.graphView.minValue * 0.75...self.graphView.maxValue * 0.75)
//        print(self.sensorData)
//    }
}
