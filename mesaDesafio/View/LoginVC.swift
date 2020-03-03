//
//  ViewController.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 27/02/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Set up login view
        setupView()
        
        //Set facebook button login
        setupFbBtn()
        
    }
    
    func setupView(){
        let backgroundColor = Utils.hexStringToUIColor(hex: COLOR_BACKGROUND)
        self.view.backgroundColor = backgroundColor
        self.navigationController?.navigationBar.barTintColor = backgroundColor
    }

    func setupFbBtn(){
        let loginButton = FBLoginButton()
        loginButton.permissions = ["email", "public_profile"]
        loginButton.delegate = self
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
}

extension LoginVC: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
        } else {
            DispatchQueue.main.async {
                if(result?.isCancelled == true){ return }
                if((result?.declinedPermissions.count)! > 0) == true{ return }
                self.performSegue(withIdentifier: "showMap", sender: nil)
            }
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logged out")
    }
}
