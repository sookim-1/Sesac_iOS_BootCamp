//
//  ProverbVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/22.
//

import UIKit

class ProverbVC: UIViewController {

    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        randomAdvice()
    }
    
    func randomAdvice() {
        let jsonDecoder = JSONDecoder()
        guard let adviceItemsData = NSDataAsset(name: "items")
        else { return }
        
        do {
            let advices: [LoveAdvice] = try jsonDecoder.decode([LoveAdvice].self, from: adviceItemsData.data)
            guard let advice = advices.randomElement() else { return }
            adviceLabel.text = "\(advice.advice) - \(advice.author)"
        } catch  {
            print("Error")
        }
    }
}
