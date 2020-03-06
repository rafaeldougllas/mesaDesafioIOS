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
        let backgroundColor = Utils.hexStringToUIColor(hex: BACKGROUND_COLOR)
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
