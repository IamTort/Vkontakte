//
//  viewController.swift
//  Pozolotina_VK
//
//  Created by angelina on 21.04.2022.
//

import UIKit
import WebKit


class ViewController: UIViewController {

    
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    override func viewDidLoad() {
           super.viewDidLoad()
           
           // Жест нажатия
           let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
           // Присваиваем его UIScrollVIew
           scrollView?.addGestureRecognizer(hideKeyboardGesture)
           
        self.view = webview
        
        webview?.navigationDelegate = self
        loadAuth()
        
    }
       
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
               // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
       NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
               // Второе — когда она пропадает
       NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       }
       
    override func viewWillDisappear(_ animated: Bool) { super.viewWillDisappear(animated)
       NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
       }
       
       
       // Когда клавиатура появляется
       @objc func keyboardWasShown(notification: Notification) {
               // Получаем размер клавиатуры
       let info = notification.userInfo! as NSDictionary
       let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
       let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
               // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
       self.scrollView?.contentInset = contentInsets
       scrollView?.scrollIndicatorInsets = contentInsets }
           //Когда клавиатура исчезает
       @objc func keyboardWillBeHidden(notification: Notification) { // Устанавливаем отступ внизу UIScrollView, равный 0 let contentInsets = UIEdgeInsets.zero scrollView?.contentInset = contentInsets
       }
       
       @objc func hideKeyboard() { self.scrollView?.endEditing(true)
       }

           //работает не верно без func shouldPerformSegue
       @IBAction func loginButton(_ sender: Any) {
           // Получаем текст логина
           guard let login = loginInput.text,
           // Получаем текст-пароль
           let password = passwordInput.text,
           // Проверяем, верны ли они
           login == "", password == "" else {
               print("неуспешная авторизация")
               return
           }
           performSegue(withIdentifier: "Login", sender: nil)
       }
       
       override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
           let login = loginInput.text!
           let password = passwordInput.text!
               if login == "" && password == "" {
                   return true
               } else {
               return false
           }

       }
       
    @IBOutlet private var webview: WKWebView? = {
        let config = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: config)
        return view
    }()
    
}


extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        if let token = params["access_token"], let userId = params["user_id"] {
            SessionSinglton.instance.token = token
            SessionSinglton.instance.userId = Int(userId)
            print(token)
            print(userId)
            //let vc = FriendViewController()
            performSegue(withIdentifier: "workPlease", sender: nil)
            decisionHandler(.cancel)
        }
        
    }
    
}

private extension ViewController {
    func loadAuth() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [URLQueryItem(name: "client_id", value: "8181012"),
                                    URLQueryItem(name: "display", value: "mobile"),
                                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                                    URLQueryItem(name: "scope", value: "friends, groups, photos"),
                                    URLQueryItem(name: "response_type", value: "token"),
                                    URLQueryItem(name: "revoke", value: "0")
        ]
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        print("request - \(request)")
        webview?.load(request)
        
    }
    
    
}
