//
//  HalfProfileAssignment.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import UIKit
import RealmSwift

class HalfProfileAssignmentVC: UIViewController {
    let localRealm = try! Realm()
    let picker = UIImagePickerController()
    let halfProfile = HalfProfile()
    var profileImage: UIImage!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
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
        halfProfile.name = nameTextField.text!
        
        try! localRealm.write {
            localRealm.add(halfProfile)
            saveImageToDocumentDirectory(imageName: "1.png", image: profileImage)
        }
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
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage = image
        } else {
            print("이미지추출 실패")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        guard let data = image.pngData() else {
            print("압축이 실패했습니다.")
            return
        }
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지를 삭제하지 못했습니다.")
            }
        }

        do {
            try data.write(to: imageURL)
            print("이미지 저장완료")
        } catch {
            print("이미지를 저장하지 못했습니다.")
        }
    }
    
}
