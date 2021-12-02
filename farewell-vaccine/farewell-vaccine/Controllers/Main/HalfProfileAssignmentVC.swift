//
//  HalfProfileAssignment.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import UIKit
import RealmSwift

class HalfProfileAssignmentVC: UIViewController, UITextFieldDelegate {
    
    let picker = UIImagePickerController()
    var profileImage: UIImage?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = "뒤로"
        
        createDismissKeyboardTapGesture()
        configureTextField()
        picker.delegate = self
    }
    
    func configureTextField() {
        nameTextField.delegate = self
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderWidth = 2
        nameTextField.layer.borderColor = UIColor.systemGray4.cgColor
        
        nameTextField.textColor = .label
        nameTextField.tintColor = .label
        nameTextField.textAlignment = .center
        nameTextField.font = UIFont.preferredFont(forTextStyle: .title2)
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.minimumFontSize = 12

        nameTextField.backgroundColor = .tertiarySystemBackground
        nameTextField.autocorrectionType = .no

        nameTextField.returnKeyType = .done
        nameTextField.placeholder = "이름을 입력하세요"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func getImageBtnClicked(_ sender: UIButton) {
        let alert =  UIAlertController(title: "원하는 사진을 선택하세요", message: nil, preferredStyle: .actionSheet)

        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.openLibrary()
        }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)

    }
    
    @IBAction func assignmentBtnClicked(_ sender: UIButton) {
        let localRealm = try! Realm()
        let halfProfile = HalfProfile()
        
        halfProfile.name = nameTextField.text!
        
        try! localRealm.write {
            if localRealm.isEmpty {
                localRealm.add(halfProfile)
            } else {
                localRealm.objects(HalfProfile.self)[0].name = nameTextField.text!
            }
        }
        
        guard let profileImage = profileImage else {
            return
        }
        
        saveImageToDocumentDirectory(imageName: "profileImage.png", image: profileImage)
    }
    
}

extension HalfProfileAssignmentVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }

    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("카메라를 이용할 수 없습니다.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageButton.setImage(image, for: .normal)
            profileImage = image
        } else {
            profileImage = UIImage(named: "logo")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        guard let data = image.pngData() else {
            return
        }
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                try FileManager.default.removeItem(at: imageURL)
            } catch {
                print("이미지 삭제 에러")
            }
        }

        do {
            try data.write(to: imageURL)
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("이미지 저장 에러")
        }
    }
    
}
