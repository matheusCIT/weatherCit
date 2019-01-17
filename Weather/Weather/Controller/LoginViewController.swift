//
//  LoginViewController.swift
//  Weather
//
//  Created by Matheus Cavalcante Teixeira on 17/01/19.
//  Copyright © 2019 Matheus Cavalcante Teixeira. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    var name: String? {
        didSet {
            self.performSegue(withIdentifier: "weatherSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.readPermissions = ["public_profile"];
        
        loginButton.delegate = self

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherSegue" {
            let viewController = segue.destination as! ViewController
            viewController.name = name
        }
    }

}

extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print(result.grantedPermissions)
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "first_name"]).start(completionHandler: { (_, result, error) in
            if let dict = result as? [String : AnyObject]{
                self.name = dict["first_name"] as! String
            }
        })

    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
}
