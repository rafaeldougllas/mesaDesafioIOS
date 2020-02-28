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
        let background = Utils.hexStringToUIColor(hex: backgroundRGB)
        self.view.backgroundColor = background
        self.navigationController?.navigationBar.barTintColor = Utils.hexStringToUIColor(hex: backgroundRGB)
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
                print("PEGOU")
            }
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logged out")
    }
}
