//
//  HalfProfileAssignment.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import UIKit
import RealmSwift
import AVFoundation
import Photos

class HalfProfileAssignmentVC: UIViewController, UITextFieldDelegate {
    
    let picker = UIImagePickerController()
    var profileImage: UIImage?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var ddayPicker: UIDatePicker!
    
    @IBOutlet weak var ddaySwitch: UISwitch!
    var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        flag = photoAuth()
        navigationController?.navigationBar.topItem?.title = "뒤로"
        
        createDismissKeyboardTapGesture()
        configureTextField()
        picker.delegate = self
        ddayPicker.isHidden = true
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

            if self.photoAuth() {
                self.openLibrary()
            }
            else {
                self.authSettingOpen(authString: "앨범")
            }
        }
//        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
//            self.openCamera()
//        }

        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
//        alert.addAction(camera)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)

    }
    
    @IBAction func assignmentBtnClicked(_ sender: UIButton) {
        let localRealm = try! Realm()
        let halfProfile: HalfProfile
        
        guard let distance = Calendar.current.dateComponents([.day], from: ddayPicker.date, to: Date()).day else {
            return
        }
        if ddaySwitch.isOn && distance > 0 {
            halfProfile = HalfProfile(name: nameTextField.text!, dday: ddayPicker.date)
        }
        else if ddaySwitch.isOn && distance <= 0 {
            presentErrorAlertOnMainThread(title: "기준일 설정을 다시해주세요", message: "기준일은 현재날짜 이전으로 지정해주세요", buttonTitle: "확인")
            halfProfile = HalfProfile(name: nameTextField.text!, dday: nil)
        }
        else {
            halfProfile = HalfProfile(name: nameTextField.text!, dday: nil)
        }
        
        let halfProfiles = localRealm.objects(HalfProfile.self)
        if !halfProfiles.isEmpty {
            let halfProfileUpdate = halfProfiles[0]
            try! localRealm.write{
                halfProfileUpdate.name = nameTextField.text!
                
                if ddaySwitch.isOn && distance > 0 {
                    halfProfileUpdate.dday = ddayPicker.date
                }
                else {
                    halfProfileUpdate.dday = nil
                }
            }
        }
        else {
            try! localRealm.write {
                 localRealm.add(halfProfile)
            }
        }

        
        guard let profileImage = profileImage else {
            presentErrorAlertOnMainThread(title: "사진을 저장해주세요", message: "", buttonTitle: "확인")
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
            
            let imageURL = documentDirectory.appendingPathComponent("profileImage.png")
            
            if FileManager.default.fileExists(atPath: imageURL.path) {
                do {
                    try FileManager.default.removeItem(at: imageURL)
                } catch {
                    print("이미지 삭제 에러")
                }
            }
            return
        }
        
        saveImageToDocumentDirectory(imageName: "profileImage.png", image: fixOrientation(img: profileImage))
    }
    
    func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return normalizedImage
    }
    
    @IBAction func clickedDdaySwitch(_ sender: UISwitch) {
        if sender.isOn {
            ddayPicker.isHidden = false
        }
        else {
            ddayPicker.isHidden = true
        }
    }
    
}

extension HalfProfileAssignmentVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func openLibrary() {

        self.picker.sourceType = .photoLibrary
        self.present(self.picker, animated: false, completion: nil)

    }
    
    func photoAuth() -> Bool {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()

        var isAuth = false

        switch authorizationStatus {
        case .authorized:
            return true
        case .denied: break
        case .limited: break
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (state) in
                if state == .authorized {
                    isAuth = true
                } else {
                    isAuth = false
                }
            }
            return isAuth
        case .restricted: break
        default: break
        }
    
        return false
    }
    
    


    func openCamera() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                
               if UIImagePickerController.isSourceTypeAvailable(.camera) {
                   self.picker.sourceType = .camera
                   self.present(self.picker, animated: false, completion: nil)
               } else {
                   print("카메라를 이용할 수 없습니다.")
               }
            } else {
                DispatchQueue.main.async {
                    self.authSettingOpen(authString: "카메라")
                }
                print("Camera: 권한 거부")
            }
        })

         
    }
    
    func cameraAuth() -> Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == AVAuthorizationStatus.authorized
    }
    
    func authSettingOpen(authString: String) {
        
        //guard let AppName = Bundle.main.infoDictionary!["CFBundleName"] as? String else { return }
        let message = "\(authString) 접근 허용되어 있지않습니다. \r\n 설정화면으로 가시겠습니까?"
        
        let alert = UIAlertController(title: "설정", message: message, preferredStyle: .alert)
        let cancle = UIAlertAction(title: "취소", style: .default) { (UIAlertAction) in
                print("\(String(describing: UIAlertAction.title)) 클릭")
            }
            
        
        let confirm = UIAlertAction(title: "확인", style: .default) { (UIAlertAction) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }

        alert.addAction(cancle)
        alert.addAction(confirm)

        self.present(alert, animated: true, completion: nil)
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
