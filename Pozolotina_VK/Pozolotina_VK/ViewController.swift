//
//  viewController.swift
//  Pozolotina_VK
//
//  Created by angelina on 21.04.2022.
//

import UIKit

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
               if login == "" && password == "" { return true
               } else {
               return false
           }

       }
       
    
}
