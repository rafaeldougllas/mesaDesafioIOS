//
//  Login+.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 05/03/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import FBSDKLoginKit

extension LoginVC: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let error = error {
            let alertController = UIAlertController(title: "Erro", message:
                "Ocorreu um erro tente novamente!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))

            self.present(alertController, animated: true, completion: nil)
            print(error)
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
