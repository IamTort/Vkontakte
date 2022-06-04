//
//  LoginViewController.swift
//  Pozolotina_VK
//
//  Created by angelina on 01.06.2022.
//

import WebKit
import UIKit


final class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            self.webView.navigationDelegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view = webView
//        webView?.navigationDelegate = self
        loadAuth()
        
    }
  
}

// расширяем наш контроллер для поддержки делегатов
extension LoginViewController: WKNavigationDelegate {
    
    // добавим метод для перехвата ответов от серввера при переходу
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        // отслеживаем переходы и либо разрешаем или отменяем их по не обходимости
        // проверяем УРЛ на который был осуществлен переход если это бланк и имеет токен то обрабатываем, если нет то переходим между страницами с помощью метода decisionHandler(.allow)
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
        
        // делим строку с параметрами на части используя разделители & и = -> получаем словарь с параметрами
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
        
        // Присвоим значения константам token и userId ключи полученые после авторизации
        if let token = params["access_token"], let userId = params["user_id"] {
            // запишем их в синглтон
            SessionSinglton.instance.token = token
            SessionSinglton.instance.userId = Int(userId)
            // выведем полученные значения на консоль
            print(token)
            print(userId)
            
            decisionHandler(.cancel)
            
            // сделаем переход на следующий контроллер
            performSegue(withIdentifier: "show", sender: nil)
        }
        
    }
    
}

private extension LoginViewController {
    func loadAuth() {
        
        // создадим post запрос для получения данных с сервера ВК
        // открытие страниы веб авторизации в вк согласно инструкции VK
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            // id зарегестрированного приложения
            URLQueryItem(name: "client_id", value: "8181012"),
            // платформа на которой запускается приложение
            URLQueryItem(name: "display", value: "mobile"),
            // Адрес, на который будет переадресован пользователь после прохождения авторизации
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            // бит маски, подтверждение запроса на разрешение использования
            URLQueryItem(name: "scope", value: "offline,friends, groups, photos"),
            // тип ответа от сервера указываем token
            URLQueryItem(name: "response_type", value: "token"),
            // строка которая должна появится после авторизации
            URLQueryItem(name: "state", value: "Hello"),
            // повторный запрос на празрешение прав 1 тру 0 фалс
            URLQueryItem(name: "revoke", value: "0")
        ]
        
        //guard let url = urlComponents.url else { return }
        // назначаем константу присваиваем ей родителя URLRequest
        let request = URLRequest(url: urlComponents.url!)
        print(request)
        // открытие страницы с помощью метода load
        webView.load(request)
    }
}
