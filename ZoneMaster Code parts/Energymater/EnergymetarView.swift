//
//  EnergymetarView.swift
//  PhysioZone
//
//  Created by Priba on 12/10/19.
//  Copyright © 2019 com.newtec-solutions.physiosone. All rights reserved.
//

import UIKit
import Charts

protocol EnergometarDelegate {
    func didSelectZone(zone: Int)
}

class EnergymetarView: UIView, ChartViewDelegate {
    
    var delegate: EnergometarDelegate?
    
    @IBOutlet var chartView: PieChartView!
    @IBOutlet weak var zoneIndicatorView: UIView!
    @IBOutlet weak var gaugeHolderView: UIView!
    var gaugeLabels = [UILabel]()
    
    @IBOutlet weak var bmView: UIView!
    @IBOutlet weak var bmLabel: UILabel!
    @IBOutlet weak var bmHolderView: UIView!
    
    @IBOutlet weak var caloryIndicatiorView: UIView!
    
    @IBOutlet weak var hrHolderView: UIView!
    @IBOutlet weak var heartRateLbl: UILabel!
    
    var isBMHolderFliped = false
    
    var gaugeView = UIView()
    
    var scaleMaxValue = 7500
    var scaleMinValue = 500
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let xibView = Bundle.main.loadNibNamed("Energymetar", owner: self, options: nil)!.first as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
                
        self.backgroundColor = .clear
        
        self.setup(pieChartView: chartView)
        self.setupPieChartData()
        chartView.delegate = self
                            
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        
        zoneIndicatorView.setHalfCornerRadius()
        caloryIndicatiorView.setHalfCornerRadius()
        hrHolderView.setHalfCornerRadius()

        self.addSubview(gaugeView)
                                
        //TODO: TMP
        //_ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tmpTimerAction), userInfo: nil, repeats: true)
        
        setSelectedZone(index: -1, hr: 0)
        setBMValue(value: 0.0)
        setCaloriesValue(value: 0.0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLayoutParent), name: NSNotification.Name(rawValue: "parentLayoutSubviews"), object: nil)
    }
    
    @objc func didLayoutParent(){
        createRingScale()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    var i = 0
    
    @objc func tmpTimerAction(){
        if i > 7 {
            i = 0
        }
        setSelectedZone(index: i, hr: Calculator.getValueForZone(zone: i) + 7)
        i += 1
//        setupPieChartData(selectedIndex: i)
//        i += 1
//        
//        if isBMHolderFliped {
//            setBMValue(value: 40)
//            setCaloriesValue(value: 4100)
//            heartRateLbl.text = "104"
//        }else{
//            setBMValue(value: 190)
//            setCaloriesValue(value: 5250)
//            heartRateLbl.text = "108"
//        }
        
    }
    
    //MARK: - Pie Chart View Setup
    
    func setup(pieChartView chartView: PieChartView) {
        chartView.usePercentValuesEnabled = false
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.7
        chartView.transparentCircleRadiusPercent = 0.61
        chartView.chartDescription?.enabled = false
        chartView.legend.enabled = false
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 110
        chartView.maxAngle = 320
        chartView.rotationEnabled = false
        chartView.highlightPerTapEnabled = true
        
    }
    
    func setupPieChartData(selectedIndex: Int = -2){
        let entries = (0..<8).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(12.5),
                                     label: "zone\(i)".localized,
                                     icon: nil)
        }
        
        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.drawValuesEnabled = false
        set.sliceSpace = 4
        
        var alphaArray = [CGFloat](repeating: 1.0, count: 8)
        if selectedIndex > -1 {
            alphaArray = [CGFloat](repeating: 0.1, count: 8)
            alphaArray[selectedIndex] = 1.0
        }else if selectedIndex == -1 && TrainingManager.shared.isTrainingON {
            alphaArray = [CGFloat](repeating: 0.1, count: 8)
        }
        
        set.colors = [
            NSUIColor(red: 255/255.0, green: 255/255.0, blue: 252/255.0, alpha: alphaArray[0]),
            NSUIColor(red: 255/255.0, green: 241/255.0, blue: 0/255.0, alpha: alphaArray[1]),
            NSUIColor(red: 99/255.0, green: 227/255.0, blue: 24/255.0, alpha: alphaArray[2]),
            NSUIColor(red: 42/255.0, green: 174/255.0, blue: 243/255.0, alpha: alphaArray[3]),
            NSUIColor(red: 0/255.0, green: 64/255.0, blue: 242/255.0, alpha: alphaArray[4]),
            NSUIColor(red: 255/255.0, green: 132/255.0, blue: 0/255.0, alpha: alphaArray[5]),
            NSUIColor(red: 241/255.0, green: 0/255.0, blue: 0/255.0, alpha: alphaArray[6]),
            NSUIColor(red: 202/255.0, green: 0/255.0, blue: 213/255.0, alpha: alphaArray[7]),
        ]
                
        let data = PieChartData(dataSet: set)
                
        data.setValueFont(.systemFont(ofSize: 11, weight: .bold))
        data.setValueTextColor (.black)
                
        chartView.data = data
        chartView.highlightValues(nil)
    }
    
    
    func setSelectedZone(index: Int, hr: Int){
        var angle:CGFloat = 0.0

        switch index {
        case -1:
            angle = -160
        case 0:
            //angle = -140
            angle = getAngleForZone(minAngle: -160, maxAngle: -120, zone: index, hr: hr)
        case 1:
            //angle = -100
            angle = getAngleForZone(minAngle: -120, maxAngle: -80, zone: index, hr: hr)
        case 2:
            //angle = -60
            angle = getAngleForZone(minAngle: -80, maxAngle: -40, zone: index, hr: hr)
        case 3:
            //angle = -20
            angle = getAngleForZone(minAngle: -40, maxAngle: 0, zone: index, hr: hr)
        case 4:
            //angle = 20
            angle = getAngleForZone(minAngle: 0, maxAngle: 40, zone: index, hr: hr)
        case 5:
            //angle = 60
            angle = getAngleForZone(minAngle: 40, maxAngle: 80, zone: index, hr: hr)
        case 6:
            //angle = 100
            angle = getAngleForZone(minAngle: 80, maxAngle: 120, zone: index, hr: hr)
        case 7:
            angle = 140
        default:
            angle = 0.0
        }
        
        UIView.animate(withDuration: 0.2) {
            self.zoneIndicatorView.transform = CGAffineTransform.identity.rotated(by: angle * CGFloat.pi/180)
        }
    }
    
    func getAngleForZone(minAngle: Int, maxAngle: Int, zone: Int, hr: Int) -> CGFloat{
        let zoneValue = Calculator.getValueForZone(zone: zone)
        let nextZoneValue = Calculator.getValueForZone(zone: zone + 1)
        let zoneDiff = nextZoneValue - zoneValue
        let zoneMidValue = zoneDiff - (nextZoneValue - hr)
        
        let zoneCoef: CGFloat = CGFloat(zoneMidValue)/CGFloat(zoneDiff)
        
        let angleAdd:CGFloat = 40.0 * zoneCoef
                
        let newAngle = CGFloat(minAngle) + angleAdd
        
        return newAngle
    }
    
    //MARK: - Pie chart delegate
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
                
        if let ent = entry as? PieChartDataEntry {
            
            switch ent.label {
            case "zone0".localized:
                delegate?.didSelectZone(zone: 0)
            case "zone1".localized:
                delegate?.didSelectZone(zone: 1)
            case "zone2".localized:
                delegate?.didSelectZone(zone: 2)
            case "zone3".localized:
                delegate?.didSelectZone(zone: 3)
            case "zone4".localized:
                delegate?.didSelectZone(zone: 4)
            case "zone5".localized:
                delegate?.didSelectZone(zone: 5)
            case "zone6".localized:
                delegate?.didSelectZone(zone: 6)
            case "zone7".localized:
                delegate?.didSelectZone(zone: 7)
            default:
                break
            }
        }

        chartView.highlightValues(nil)
    }
    
    //MARK: - Gauge View Setup

    func createRingScale() {
        
        gaugeView.removeFromSuperview()
        for lbl in gaugeLabels {
            lbl.removeFromSuperview()
        }
        gaugeLabels.removeAll()
        
        gaugeView = UIView(frame: gaugeHolderView.frame)
        gaugeView.backgroundColor = .clear
        self.gaugeHolderView.addSubview(gaugeView)
                
        let center = CGPoint(x: (gaugeView.bounds.width)/2 ,y: gaugeView.bounds.height/2)
        let radius : CGFloat = 86
        let count = 15

        var angle = CGFloat(13*Double.pi/18)
        let step = CGFloat(2 * Double.pi - Double.pi/3)  / CGFloat(count)
        
        let valueStep = (scaleMaxValue)/count
        var currentValue = scaleMinValue

        // set objects around circle
        for i in 0...count-1{
            let x = cos(angle) * radius + center.x
            let y = sin(angle) * radius + center.y
            
            let label = UILabel()
            label.text = i > 7 ? "\(currentValue) --" : "-- \(currentValue)"
            label.font = UIFont.systemFont(ofSize: 7, weight: .medium)
            label.textColor = UIColor.black
            label.sizeToFit()
            label.frame.origin.x = x - label.frame.midX
            label.frame.origin.y = y - label.frame.midY
            
            if i < 8 {
                label.transform = CGAffineTransform(rotationAngle: angle + CGFloat.pi)
            }else {
                label.transform = CGAffineTransform(rotationAngle: angle)
            }
            
            gaugeHolderView.addSubview(label)
            gaugeLabels.append(label)
            
            angle += step
            currentValue += valueStep
        }
        
        
        self.setNeedsDisplay()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }

    //MARK: - BM View Methods
    
    func setBMValue(value: Double){
        var angle:CGFloat = 0
        
        let maxValue:Double = Double(scaleMaxValue - scaleMinValue)
        let valuePercent = ((value - Double(scaleMinValue)) * 100)/maxValue
                
        angle = CGFloat((280.0 * valuePercent)/100) - 140.0 + 90.0
        
        if angle > 90 && !isBMHolderFliped{
            isBMHolderFliped = true
            bmLabel.transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
            bmHolderView.transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
        }else if angle < 90 && isBMHolderFliped{
            isBMHolderFliped = false
            bmLabel.transform = CGAffineTransform(scaleX: transform.a, y: transform.d)
            bmHolderView.transform = CGAffineTransform(scaleX: transform.a, y: transform.d)
        }
        
        UIView.animate(withDuration: 0.2) {
            self.bmView.transform = CGAffineTransform.identity.rotated(by: CGFloat(angle) * CGFloat.pi/180)
        }
    }
    
    //MARK: - Buttons actions
    
    @IBAction func warmupZoneBtnAction(_ sender: Any) {
        self.delegate?.didSelectZone(zone: 0)
    }
    
    @IBAction func recZoneBtnAction(_ sender: Any) {
        self.delegate?.didSelectZone(zone: 1)
    }
    
    @IBAction func en1ZoneBtnAction(_ sender: Any) {
        self.delegate?.didSelectZone(zone: 2)
    }
    
    @IBAction func en2ZoneBtnAction(_ sender: Any) {
        self.delegate?.didSelectZone(zone: 3)
    }
    
    @IBAction func en3ZoneBtnAction(_ sender: Any) {
        self.delegate?.didSelectZone(zone: 4)
    }
    
    @IBAction func vo2ZoneBtnAction(_ sender: Any) {
        self.delegate?.didSelectZone(zone: 5)
    }
    
    @IBAction func ltZoneBtnAction(_ sender: Any) {
        self.delegate?.didSelectZone(zone: 6)
    }
    
    @IBAction func lmaxZoneBtnAction(_ sender: Any) {
        self.delegate?.didSelectZone(zone: 7)
    }

    
    //MARK: - Calories Indicator View Methods

    func setCaloriesValue(value: Double){
        var angle:CGFloat = 0
        
        //let minAngle:CGFloat = -140
        //let maxAngle:CGFloat = 140
        
        
        let maxValue:Double = Double(scaleMaxValue - scaleMinValue)
        let valuePercent = ((value - Double(scaleMinValue)) * 100)/maxValue
                
        angle = CGFloat((280.0 * valuePercent)/100) - 140.0

        UIView.animate(withDuration: 0.2) {
            self.caloryIndicatiorView.transform = CGAffineTransform.identity.rotated(by: angle * CGFloat.pi/180)
        }
    }
    
}

extension UIView {
    func setHalfCornerRadius() {
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func flipUpSideDown(){
        self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    /// Flip view horizontally.
    func flipX() {
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
    }

    /// Flip view vertically.
    func flipY() {
        transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
    }
}

