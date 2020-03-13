//
//  SearchViewController.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/12/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import SwiftUI

class SearchViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLogo()
        setupTextField()

        view.addSubview(getFollowersButton)
        getFollowersButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        getFollowersButton.anchor(top: getFollowersTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: view.frame.height / 12)
        getFollowersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissKeyBoard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func setupLogo() {
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: view.frame.height / 7, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 250, height: 250)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func setupTextField() {
        view.addSubview(getFollowersTextField)
        getFollowersTextField.delegate = self
        getFollowersTextField.anchor(top: logoImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: view.frame.height / 12)
        getFollowersTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }



    @objc func handleSearch() {
        let followersVC = FollowersViewController()
        guard let textCount = getFollowersTextField.text?.count else { return }
        if textCount > 0 {
            followersVC.username = getFollowersTextField.text
            followersVC.view.backgroundColor = .systemBackground
            followersVC.navigationItem.title = getFollowersTextField.text
            getFollowersTextField.text = ""
            navigationController?.pushViewController(followersVC, animated: true)
        }
    }

    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "gh-logo").withRenderingMode(.alwaysOriginal)
        iv.clipsToBounds = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        return iv
    }()

    let getFollowersTextField: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 16
        tf.placeholder = "Enter User"
        tf.textAlignment = .center
        tf.layer.borderColor = UIColor.systemGray6.cgColor
        tf.minimumFontSize = 12
        tf.autocorrectionType = .no
        tf.borderStyle = .roundedRect
        tf.returnKeyType = .go
        return tf
    }()

    let getFollowersButton = GetFollowersButton(backgroundColor: .systemPink, title: "Get Followers", coloredBackground: .no)

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSearch()
        textField.resignFirstResponder()
        return true
    }

    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

//struct SearchView: View {
//
//    var didPushButton: (String) -> () = {_ in }
//
//    @State var name = ""
//
//    var body: some View {
//        VStack {
//            Image("gh-logo").resizable().frame(width: 200, height: 200, alignment: .center).padding(.bottom, 100)
//            TextField("Enter Name", text: $name)
//                .frame(alignment: .center)
//                .multilineTextAlignment(.center)
//                .padding(24)
//                .cornerRadius(18)
//                .padding(.leading)
//                .padding(.trailing)
//                //.border(RoundedRectangle.init(cornerRadius: 22))
//            Spacer()
//
//            Button(action: {
//                self.didPushButton(self.name)
//            }, label: {
//                HStack {
//                    Spacer()
//                    Text("Search").foregroundColor(.white).padding(24).frame(maxWidth: .infinity).background(Color.green).cornerRadius(18).padding(.leading, 8).padding(.trailing, 8)
//                    Spacer()
//                }
//            })
//            Spacer()
//        }.padding(.top, 50)
//    }
//}

//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}

