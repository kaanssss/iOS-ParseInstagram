//
//  FirstViewController.swift
//  ParseInstaClone
//
//  Created by Kaan Yalçınkaya on 8.02.2022.
//

import UIKit
import Parse

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
                                //PARSE İÇERİSİNE KAYDETTİĞİMİZDEN BİR ARRAY OLUŞTURUYORUZ.
    
    var postOwnerArray = [String]() //Parse içerisinde verileri tutan kullanıcı.
    var postCommentArray = [String]()
    var postUUIDArray = [String]()
    var postImageArray = [PFFileObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
            
    }
                                //NOTİFİCATİON CENTER BİLDİRİM KONTROLÜ İÇİN WİLLAPPEAR KULLANIYORUZ.
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(FeedVC.getData), name: NSNotification.Name(rawValue: "newPost"), object: nil) //addObserver methodu ile kayıt ediyoruz.
                
    }
    
                                //PARSE İÇERİSİNDEN VERİ ÇEKMEK.
    
    @objc func getData(){ //objc kullanmamızın sebebi notification center içerisindeki selector.
        
        let query = PFQuery(className: "Posts")
        query.addDescendingOrder("createdAt") //Parse içerisindeki createdAt tarihlerine göre listelemek için.
        
        query.findObjectsInBackground { objects, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                
                                //YÜKLENEN RESİMLERİN LOOP A GİRMEMESİ İÇİN.
                
                self.postOwnerArray.removeAll(keepingCapacity: false)
                self.postImageArray.removeAll(keepingCapacity: false)
                self.postUUIDArray.removeAll(keepingCapacity: false)
                self.postCommentArray.removeAll(keepingCapacity: false)
                
                
                                //PARSE İÇERİSİNDE FAZLA OBJE OLACAĞI İÇİN BU OBJELERİ LOOP A SOKMAMIZ LAZIM.
                
                if objects!.count > 0 { //Objelerin içerisinde birşey geldiyse diye yapıyoruz.
                    for object in objects! {
                        
                        self.postOwnerArray.append(object.object(forKey: "postowner") as! String)
                        self.postCommentArray.append(object.object(forKey: "postcomment") as! String)
                        self.postUUIDArray.append(object.object(forKey: "postuuid") as! String)
                        self.postImageArray.append(object.object(forKey: "postimage") as! PFFileObject)
                    
                }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func logOutClicked(_ sender: Any) {
        
        PFUser.logOutInBackground { error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                
                                    //HATA MESAJI BOŞSA
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.synchronize()
                
                let signIn = self.storyboard?.instantiateViewController(withIdentifier: "signIn") as! signInVC
                
                let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                
                delegate.window?.rootViewController = signIn
                
                delegate.rememberUser()
                
                self.performSegue(withIdentifier: "toBackMain", sender: nil)
                
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                                    //KULLANICI BİLGİLERİNİN TABLEVİEW İÇERİSİNE AKTARILMASI.
        return postOwnerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        
                                    //CELL İÇERİSİNDEKİ GÖRÜNTÜ.
        cell.userNameLabel.text = postOwnerArray[indexPath.row]
        cell.postCommentText.text = postCommentArray[indexPath.row]
        cell.postUUIDLabel.text = postUUIDArray[indexPath.row]
        
                                    //PARSE İÇERİSİNDEN IMAGE ÇEKMEK.
        
        postImageArray[indexPath.row].getDataInBackground { data, error in //Sıra sıra postimage içerisindekileri indirecek.
            if error != nil {
                
            }
            else {
                cell.postImage.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    
    
    
}

