//
//  signInVC.swift
//  ParseInstaClone
//
//  Created by Kaan Yalçınkaya on 8.02.2022.
//

/*
                    PARSE İÇERİSİNE VERİ KAYDETMEK İÇİN PARSE OBJESİ KULLANIYORUZ.
let parseObject = PFObject(className: "Fruits")
parseObject["name"] = "Apple"
parseObject["calories"] = 100
                    EKLEDİĞİMİZ OBJELERİ KAYIT ETMEK İÇİN.(HER ZAMAN BACKGROUND VE BLOCK OLANLARI KULLAN)
                    SUCCESS YAZMAMIZIN SEBEBİ SAVE İŞLEMİNİN GERÇEKTEN YAPILIP YAPILMADIĞINI GÖSTERİYOR.)
parseObject.saveInBackground { success, error in
    if error != nil {
        //LOCALİZED DESCRİPTİON NEDİR ? KULLANICININ HATA MESAJINI ANLAYABİLDİĞİ ŞEKİLDE ANLAT.)
        print(error?.localizedDescription)
    }
    else {
        print("saved")
    }
 
                    PARSE İÇERİSİNDE OLUŞTURDUĞUMUZ VERİLERİ ÇEKMEK.
 let query = PFQuery(className: "Fruits")
 query.findObjectsInBackground { objects, error in
     if error != nil {
         print(error?.localizedDescription)
     }
     else {
         print(objects)
     }
 }
 
}*/

import UIKit
import Parse

class signInVC: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let currentUser = PFUser.current()
//        if currentUser != nil{
//            performSegue(withIdentifier: "toTabBar", sender: nil)
//
//
//
//    }
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        
                                        //KULLANICI USER PASSWORD KISIMLARINI BOŞ BIRAKAMAMSI İÇİN.

        if userNameText.text != "" && passwordText.text != "" {
            print("userNameText: \(userNameText.text!)")
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { user, error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "username/password needed", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    print("username: \(self.userNameText.text!)")
                }
                
                else {
                    
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                                        //KULLANICI HATIRLA REMEMBER ME
                    UserDefaults.standard.set(self.userNameText.text!, forKey: "username")
                    UserDefaults.standard.synchronize()
                    
                   let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                   delegate.rememberUser()
                    
                }
                
            }
            
                                        //KULLANICI NASIL OLUŞTURULUR ?
            
            let user = PFUser()
            user.username = userNameText.text! //username ve password değerlerini main text içerisinden veriyoruz.
            user.password = passwordText.text! //Ünlem koyuyoruz kullanıcının boş geçememesi lazım.
            
                
        }
        else {
                                        //KULLANICI BOŞ BIRAKIRSA HATA MESAJI.
            
            let alert = UIAlertController(title: "Error", message: "username/password needed", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
                                        //KULLANICI USER PASSWORD KISIMLARINI BOŞ BIRAKAMAMASI İÇİN.
        
        if userNameText.text != "" && passwordText.text != "" {
            print("userNameText: \(userNameText.text!)")
            
                                        //KULLANICI NASIL OLUŞTURULUR ?
            
            let user = PFUser()
            user.username = userNameText.text! //username ve password değerlerini main text içerisinden veriyoruz.
            user.password = passwordText.text! //Ünlem koyuyoruz kullanıcının boş geçememesi lazım.
            
                                        //KULLANICI EMAİL PASSWORD BOŞ BIRAKMAZSA NE YAPICAĞIZ ?
            
            user.signUpInBackground { success, error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    print("passwordText: \(self.passwordText.text!)")
                }
                else{
                    
                                        //KULLANICI HATIRLA REMEMBER ME
                    UserDefaults.standard.set(self.userNameText.text!, forKey: "username")
                    UserDefaults.standard.synchronize()

                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberUser()
                }
            }
        }
        else {
                                        //KULLANICI BOŞ BIRAKIRSA HATA MESAJI.
            
            let alert = UIAlertController(title: "Error", message: "username/password needed", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        
    }
        
                            
    
}
