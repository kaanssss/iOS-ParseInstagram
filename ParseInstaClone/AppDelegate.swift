//
//  AppDelegate.swift
//  ParseInstaClone
//
//  Created by Kaan Yalçınkaya on 19.01.2022.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //DİD FİNİSH LAUNCHİNG WİTH OPTİONS ALTINDA YAPILMASININ SEBEBİ; PROJE AÇILIR AÇILMAZ PARSE BAĞLANTISI KURULMASINI İSTEDİĞİMİZ İÇİN BURADA İŞLEMİ GERÇEKLEŞTİRİYORUZ.
        
        let configuration = ParseClientConfiguration { ParseMutableClientConfiguration in
            ParseMutableClientConfiguration.applicationId = "TZxsGmJ86RBIMH9VOXz4TdqfXRCJjwyRMrM1rcWD"
            ParseMutableClientConfiguration.clientKey = "XwERYq1M8eEcEe3WknOrcI6AH4QkugEjrUBs4YVf"
            ParseMutableClientConfiguration.server = "https://parseapi.back4app.com/"
            
        }
        
        //YUKARIDAKİ İŞLEMLERDEN SONRA PARSE İŞLEMİNİ BAŞLATMAK İÇİN.
        
        Parse.initialize(with: configuration)
        
        //PARSE İÇERİSİNDE VERİ YAZIP OKUYABİLMEK İÇİN İZİN.
        
        let defaultACL = PFACL()
        defaultACL.hasPublicReadAccess = true
        defaultACL.hasPublicWriteAccess = true
        PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
        
        rememberUser()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
                    
                            //KULLANICI HATIRLA REMEMBER ME
    func rememberUser() {

        let user : String? = UserDefaults.standard.string(forKey: "username")

                            //EĞER KULLANICI KAYITLI İSE ANA EKRANI TAB BAR OLARAK AÇ
        if user != nil {

            let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

            let tabBar = board.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController

                            //BAŞLANGIÇ OKUNU TAB BARA ALMA

            window?.rootViewController = tabBar
            
        }
        
    }


}

