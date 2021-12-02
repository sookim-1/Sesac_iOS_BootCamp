//
//  TestResultVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/29.
//

import UIKit

class TestResultVC: UIViewController, SendDataDelegate {

    @IBOutlet var resultLabel: UILabel!
    var testResultCategory: TestCategory?
    var resultCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        configureResult()
    }
    
    func sendData(testResultCount: Int, category: TestCategory) {
        testResultCategory = category
        resultCount = testResultCount
    }
    
    func configureResult() {
        switch testResultCategory {
        case .marriage:
            marriageTestResult(testResultCount: resultCount!)
        case .attachment:
            attachmentTestResult(testResultCount: resultCount!)
        case .ability:
            abilityTestResult(testResultCount: resultCount!)
        case .none:
            print("error")
        }
    }
    
    func marriageTestResult(testResultCount: Int) {
        switch testResultCount {
        case 0...3:
            resultLabel.text = "결혼하세요"
        default:
            resultLabel.text = "결혼하지마세요"
        }
    }
    
    func attachmentTestResult(testResultCount: Int) {
        switch testResultCount {
        case 0...3:
            resultLabel.text = "불안형"
        default:
            resultLabel.text = "안정형"
        }
    }
    
    func abilityTestResult(testResultCount: Int) {
        switch testResultCount {
        case 0...3:
            resultLabel.text = "연애능력 초수"
        default:
            resultLabel.text = "연애능력 고수"
        }
    }
    
    
    @IBAction func clickedHomeBtn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
