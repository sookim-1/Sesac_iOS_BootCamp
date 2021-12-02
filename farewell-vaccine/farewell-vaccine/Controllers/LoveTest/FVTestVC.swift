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

        testCategoryPickerView.delegate = self
        testCategoryPickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        self.title = "테스트하기"
        self.navigationController?.isNavigationBarHidden = false
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(presentSideMenu))
        menuButton.tintColor = .customPink
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func presentSideMenu() {
        guard let sideMenuNC = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuNC") as? SideMenuNC else { return }
        
        self.present(sideMenuNC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = self.testCategoryPickerView.selectedRow(inComponent: 0)

        guard let testingVC = segue.destination as? TestingVC else { return }
        
        testingVC.testCategory = TestCategory.allCases[row]
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
