//
//  IntroduceEditVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import UIKit

class IntroduceEditVC: UIViewController {

    @IBOutlet weak var editToolbar: UIToolbar!
    
    // 카테고리별 컬렉션뷰
    var fontCollectionView: UICollectionView!
    var textColorCollectionView: UICollectionView!
    var backgroundCollectionView: UICollectionView!
    
    // 카테고리별 배열
    var fontImageArray: [ImageListView] = [
        ImageListView(category: .font, itemImage: .add),
        ImageListView(category: .font, itemImage: .actions),
        ImageListView(category: .font, itemImage: .checkmark),
        ImageListView(category: .font, itemImage: .add),
        ImageListView(category: .font, itemImage: .remove),
    ]
    var textColorImageArray: [ImageListView] = [
        ImageListView(category: .textColor, itemImage: nil, itemColor: .systemRed),
        ImageListView(category: .textColor, itemImage: nil, itemColor: .systemPink),
        ImageListView(category: .textColor, itemImage: nil, itemColor: .systemOrange),
        ImageListView(category: .textColor, itemImage: nil, itemColor: .systemBrown),
        ImageListView(category: .textColor, itemImage: nil, itemColor: .systemGreen),
        ImageListView(category: .textColor, itemImage: nil, itemColor: .systemBlue),
        ImageListView(category: .textColor, itemImage: nil, itemColor: .systemPurple),
        ImageListView(category: .textColor, itemImage: nil, itemColor: .systemYellow),
        ImageListView(category: .textColor, itemImage: nil, itemColor: .systemGray)
    ]
    var backgroundImageArray: [ImageListView] = [
        ImageListView(category: .background, itemImage: UIImage(named: "logo")),
        ImageListView(category: .background, itemImage: UIImage(named: "logo")),
        ImageListView(category: .background, itemImage: UIImage(named: "logo")),
        ImageListView(category: .background, itemImage: UIImage(named: "logo")),
        ImageListView(category: .background, itemImage: UIImage(named: "logo"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureToolbar()
    }
 
    func configureToolbar() {
        let fontBarItem = UIBarButtonItem(image: UIImage(systemName: "t.circle"), style: .plain, target: self, action: #selector(selectFontStyle))
        let textColorBarItem = UIBarButtonItem(image: UIImage(systemName: "textformat"), style: .plain, target: self, action: #selector(selectTextColor))
        let textSizeBarItem = UIBarButtonItem(image: UIImage(systemName: "text.cursor"), style: .plain, target: self, action: #selector(selectTextSize))
        let backgroundBarItem = UIBarButtonItem(image: UIImage(systemName: "photo"), style: .plain, target: self, action: #selector(selectBackgroundImage))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        editToolbar.setItems([fontBarItem, flexibleSpace, textColorBarItem, flexibleSpace, textSizeBarItem, flexibleSpace, backgroundBarItem], animated: true)
        editToolbar.tintColor = .customPink
    }
    
    func configureFontCollectionView() {
        fontCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        fontCollectionView.delegate = self
        fontCollectionView.dataSource = self
        fontCollectionView.backgroundColor = .customPink
        view.addSubview(fontCollectionView)
        fontCollectionView.register(EditCell.self, forCellWithReuseIdentifier: EditCell.reuseID)
    }
    
    func configureTextColorCollectionView() {
        textColorCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        textColorCollectionView.delegate = self
        textColorCollectionView.dataSource = self
        textColorCollectionView.backgroundColor = .systemRed
        view.addSubview(textColorCollectionView)
        textColorCollectionView.register(EditCell.self, forCellWithReuseIdentifier: EditCell.reuseID)
    }

    func configureBackgroundCollectionView() {
        backgroundCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        backgroundCollectionView.delegate = self
        backgroundCollectionView.dataSource = self
        backgroundCollectionView.backgroundColor = .systemBlue
        view.addSubview(backgroundCollectionView)
        backgroundCollectionView.register(EditCell.self, forCellWithReuseIdentifier: EditCell.reuseID)
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(with: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    @objc func selectFontStyle() {
        configureFontCollectionView()
        fontCollectionView.collectionViewLayout = createThreeColumnFlowLayout()
    }
    
    @objc func selectTextColor() {
        configureTextColorCollectionView()
        textColorCollectionView.collectionViewLayout = createThreeColumnFlowLayout()
    }
    
    @objc func selectTextSize() {
        
    }
    
    @objc func selectBackgroundImage() {
        configureBackgroundCollectionView()
        backgroundCollectionView.collectionViewLayout = createThreeColumnFlowLayout()
    }
    
}

extension IntroduceEditVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case fontCollectionView:
            return fontImageArray.count
        case textColorCollectionView:
            return textColorImageArray.count
        case backgroundCollectionView:
            return backgroundImageArray.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditCell.reuseID, for: indexPath) as? EditCell else { return UICollectionViewCell() }
        switch collectionView {
        case fontCollectionView:
            print("font")
            cell.configureCategory(categoryImageListView: fontImageArray[indexPath.item])
            //cell.imageListView = fontImageArray[indexPath.item]
        case textColorCollectionView:
            print("textColor")
            
            cell.configureCategory(categoryImageListView: textColorImageArray[indexPath.item])
            print(textColorImageArray[indexPath.item].backgroundColor)
            //cell.imageListView = textColorImageArray[indexPath.item]
        case backgroundCollectionView:
            print("background")
            
            cell.configureCategory(categoryImageListView: backgroundImageArray[indexPath.item])
            //cell.imageListView = backgroundImageArray[indexPath.item]
        default:
            print("예외처리")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.removeFromSuperview()
    }
}

