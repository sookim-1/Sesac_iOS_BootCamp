//
//  FVTestVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/21.
//

import UIKit

class FVTestVC: UIViewController {
    @IBOutlet weak var testCategoryPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        testCategoryPickerView.delegate = self
        testCategoryPickerView.dataSource = self
        print(TestCategory.allCases[1].rawValue)
    }
    
    func configureNavigationBar() {
        self.title = "테스트하기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.customPink]
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(presentSideMenu))
        menuButton.tintColor = .customPink
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func presentSideMenu() {
        guard let sideMenuNC = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuNC") as? SideMenuNC else { return }
        
        self.present(sideMenuNC, animated: true)
    }

    @IBAction func startTestBtn(_ sender: UIButton) {
        let row = self.testCategoryPickerView.selectedRow(inComponent: 0)
        self.testCategoryPickerView.selectRow(row, inComponent: 0, animated: false)
    }
}

extension FVTestVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TestCategory.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(TestCategory.allCases[row].rawValue)"
    }
    
}
