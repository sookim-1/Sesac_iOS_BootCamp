//
//  ProverbVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/22.
//

import UIKit

class LoveAdviceVC: UIViewController {

    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        randomAdvice()
    }
    
    func configureNavigationBar() {
        self.title = "명언"
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(presentSideMenu))
        menuButton.tintColor = .customPink
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func presentSideMenu() {
        guard let sideMenuNC = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuNC") as? SideMenuNC else { return }
        
        self.present(sideMenuNC, animated: true)
    }
    
    private func randomAdvice() {
        let jsonDecoder = JSONDecoder()
        guard let adviceItemsData = NSDataAsset(name: "items")
        else {
            presentErrorAlertOnMainThread(title: "잘못된 에셋", message: "에셋을 가져올 수 없습니다.", buttonTitle: "확인")
            return
        }
        
        do {
            let advices: [LoveAdvice] = try jsonDecoder.decode([LoveAdvice].self, from: adviceItemsData.data)
            guard let advice = advices.randomElement()
            else {
                return
            }
            adviceLabel.text = "\(advice.advice)\n\n\(advice.author)"
        } catch {
            presentErrorAlertOnMainThread(title: "디코드 에러", message: "디코딩 에러발생", buttonTitle: "확인")
        }
    }
    
}
