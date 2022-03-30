//
//  SecondViewController.swift
//  ParseInstaClone
//
//  Created by Kaan Yalçınkaya on 8.02.2022.
//

import UIKit
import Parse

class UploadVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                                        //HERHANGİ BİR NOKTAYA BASILDIĞINDA KLAVYE KAPANMASI İÇİN.
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(UploadVC.hideKeyboard))
        self.view.addGestureRecognizer(keyboardRecognizer)
        
                                        //GESTURE RECOGNİZER.
        
        postImage.isUserInteractionEnabled = true // Kullanıcı tıklayabilmesi için
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UploadVC.choosePhoto))
        postImage.addGestureRecognizer(gestureRecognizer)
        
        
                                        //BİR RESİM SEÇİLENE KADAR.
        postButton.isEnabled = false

    }
    
    @objc func hideKeyboard () {
        self.view.endEditing(true)
    }
    
    @objc func choosePhoto() {
        
                                        //POST IMAGE BURADA NE YAZIYORSA ONU YAPTIRACAK.
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary // Source Type fotoğrafın nereden yükleneceğini söylüyor.
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
        
    }
    
                                        //RESİM SEÇİLDİKTEN SONRA NE OLACAK ?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        postImage.image = info[.originalImage] as? UIImage // Orjinal image alma.
        self.dismiss(animated: true, completion: nil) // Picker kapatıp ekrana geri dönmek için.
        
                                        //BİR RESİM SEÇİLDİKTEN SONRA.
        postButton.isEnabled = true
        
    }
    
        
                                        //TEKRAR FALSE YAPMAMIZIN SEBEBİ ÇOK FAZLA TIKLAMMASINI İSTEMEMEMİZ.
        
    @IBAction func postClicked(_ sender: Any) {
    
    postButton.isEnabled = false
        //print("\(commentText.text)")
        
                                        //IMAGE İÇERİSİNDE KENDİ ID NUMARASINI OLUŞTURMAK.
        
        let data = postImage.image?.jpegData(compressionQuality: 0.5)
        let pfImage = PFFileObject(name: "image", data: data!)
        
                                        //RESİMLER İÇİN UNİQE ID GEREKLİ.
        
        let uuid = UUID().uuidString
        let uuidPost = "\(uuid) \(PFUser.current()!.username!)"
        
                                        //UPLOAD VC İÇERİSİNDEKİ PARSE VERİ İŞLEMLERİ
        
        let object = PFObject(className: "Posts")
        object["postcomment"] = commentText.text
        object["postowner"] = PFUser.current()!.username! //Uygulama içerisindeki kullanıcıdan bilgi almak için PFUser kullandık.
        object["postimage"] = pfImage
        object["postuuid"] = uuidPost
        
        object.saveInBackground { success, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                
                self.commentText.text = ""
                self.postImage.image = UIImage(named: "image.png")
                self.tabBarController?.selectedIndex = 0 //Aynı tabbar içerisinde oldukları için segue yapmamıza gerek yok.(0 feed 1 upload).
                
                                    //BİR İSİMLE BİLDİRİ YOLLAMAK FEEDVC İÇERİSİNE MESAJ YOLLAMAK İÇİN.
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPost"),  object: nil)
            }
        }
        
                                        
        
    
    
    }
    
}
