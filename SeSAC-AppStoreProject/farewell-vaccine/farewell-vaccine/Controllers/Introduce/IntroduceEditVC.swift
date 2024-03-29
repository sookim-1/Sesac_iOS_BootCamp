//
//  IntroduceEditVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import UIKit
import RealmSwift

class IntroduceEditVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var editToolbar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var introduceTextView: UITextView!
    private var uiFontStyle: [UIFont.TextStyle] = []
    private var itemArray: [String] = []
    private var sizeItemArray: [Int] = []
    private var editItemCategory: EditCategory?
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(finishEdit))
        configureToolbar()
        configureTableView()
        introduceTextView.delegate = self
        
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        
        let introduces = localRealm.objects(Introduce.self)
        
        if !introduces.isEmpty {
            let introduceUpdate = introduces[0]
            try! localRealm.write {
                introduceTextView.text = introduceUpdate.text
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController()?.gestureEnabled = false

        introduceTextView.backgroundColor = loadColorFromDocumentDirectory(name: "colors")
        introduceTextView.font = loadFontFromDocumentDirectory(fontName: "fonts")
        introduceTextView.textColor = loadColorFromDocumentDirectory(name: "textColors")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController()?.gestureEnabled = true
    }
    
    @objc func finishEdit() {
        saveIntroduceToDocumentDirectory(fonts: introduceTextView.font ?? .systemFont(ofSize: 17), colors: introduceTextView.backgroundColor ?? .systemBackground, textColors: introduceTextView.textColor ?? .label)
        saveText()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      if (text == "\n") {
        textView.resignFirstResponder()
      } else {
      }
      return true
    }
    
    func saveText() {
        let introduce = Introduce(text: introduceTextView.text ?? "")
        let introduces = localRealm.objects(Introduce.self)
        
        if !introduces.isEmpty {
            let introduceUpdate = introduces[0]
            try! localRealm.write {
                introduceUpdate.text = introduceTextView.text ?? ""
            }
        }
        else {
            try! localRealm.write {
                 localRealm.add(introduce)
            }
        }
    }
 
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemPink
        tableView.isHidden = true
    }
    
    func loadColorFromDocumentDirectory(name: String) -> UIColor? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let colorURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(name)
            if let data = try? Data(contentsOf: colorURL) {
                return UIColor.color(data: data)
            }
        }
        return nil
    }
    
    func loadFontFromDocumentDirectory(fontName: String) -> UIFont? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let fontURL = URL(fileURLWithPath: directoryPath).appendingPathComponent("fonts")
            if let data = try? Data(contentsOf: fontURL) {
                return UIFont.font(data: data)
            }
 
        }
        return nil
    }
    
    func saveIntroduceToDocumentDirectory(fonts: UIFont, colors: UIColor, textColors: UIColor) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        
        let fontURL = documentDirectory.appendingPathComponent("fonts")
        let colorURL = documentDirectory.appendingPathComponent("colors")
        let textColorURL = documentDirectory.appendingPathComponent("textColors")
        
        guard let colorData = colors.encode(),
              let textColorData = textColors.encode(),
              let fontData = fonts.encode()
        else {
            return
        }
        saveFileManager(data: fontData, url: fontURL)
        saveFileManager(data: textColorData, url: textColorURL)
        saveFileManager(data: colorData, url: colorURL)
    }
    
    func saveFileManager(data: Data, url: URL) {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                print("삭제 에러")
            }
        }

        do {
            try data.write(to: url)

            self.navigationController?.popViewController(animated: true)
        } catch {
            print("저장에러 발생")
        }
    }
    
    
    func configureToolbar() {
        let fontBarItem = UIBarButtonItem(image: UIImage(systemName: "t.circle"), style: .plain, target: self, action: #selector(selectFontStyle))
        let textColorBarItem = UIBarButtonItem(image: UIImage(systemName: "textformat"), style: .plain, target: self, action: #selector(selectTextColor))
        let textSizeBarItem = UIBarButtonItem(image: UIImage(systemName: "text.cursor"), style: .plain, target: self, action: #selector(selectTextSize))
        let backgroundBarItem = UIBarButtonItem(image: UIImage(systemName: "photo"), style: .plain, target: self, action: #selector(selectBackgroundColor))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        editToolbar.setItems([fontBarItem, flexibleSpace, textColorBarItem, flexibleSpace, textSizeBarItem, flexibleSpace, backgroundBarItem], animated: true)
        editToolbar.tintColor = .customPink
    }
 
    @objc func selectFontStyle() {
        tableView.isHidden = false
        configureFontStyleDataSource()
        editItemCategory = .font
        tableView.reloadData()
    }
    
    @objc func selectTextColor() {
        tableView.isHidden = false
        configureColorDataSource()
        editItemCategory = .textColor
        tableView.reloadData()
    }
    
    @objc func selectTextSize() {
        tableView.isHidden = false
        for i in 1...30 {
            sizeItemArray.append(i)
        }
        sizeItemArray = Array<Int>(1...30)
        editItemCategory = .textSize
        tableView.reloadData()
    }
    
    @objc func selectBackgroundColor() {
        tableView.isHidden = false
        configureColorDataSource()
        editItemCategory = .background
        tableView.reloadData()
    }
    
}

extension IntroduceEditVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        editItemCategory == .textSize ? sizeItemArray.count : itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToolbarTableViewCell", for: indexPath) as? ToolbarTableViewCell
        else { return UITableViewCell() }
        editItemCategory == .textSize ? (cell.itemLabel.text = "\(sizeItemArray[indexPath.row])") : (cell.itemLabel.text = itemArray[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("abcd")
        switch editItemCategory {
        case .font:
            FontWeight.allCases.forEach {
                if $0.kind == itemArray[indexPath.row] {
                    introduceTextView.font = UIFont.systemFont(ofSize: introduceTextView.font?.pointSize ?? 14, weight: $0.value)
                }
            }
            
            tableView.isHidden = true
        case .textSize:
            introduceTextView.font = .systemFont(ofSize: CGFloat(sizeItemArray[indexPath.row]))
            tableView.isHidden = true
        case .textColor:
            ColorBackground.allCases.forEach {
                if $0.kind == itemArray[indexPath.row] {
                    introduceTextView.textColor = $0.value
                }
            }
            tableView.isHidden = true
        case .background:
            ColorBackground.allCases.forEach {
                if $0.kind == itemArray[indexPath.row] {
                    introduceTextView.backgroundColor = $0.value
                }
            }
            tableView.isHidden = true
        case .none:
            print("error")
        }
    }
}

extension IntroduceEditVC {
    func configureFontStyleDataSource() {
        itemArray = ["UltraLight", "Thin", "Light", "Regular", "Medium", "Semibold", "Bold", "Heavy", "Black"]
    }
    
    func configureColorDataSource() {
        itemArray = ["빨강", "주황", "노랑", "초록", "파랑", "보라", "검정"]
    }
    
    
}

