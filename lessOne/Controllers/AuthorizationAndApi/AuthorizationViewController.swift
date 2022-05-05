//
//  AuthorizationViewController.swift
//  lessOne
//
//  Created by Евгений Ефименко on 27.04.2022.
//

import UIKit
import WebKit

class AuthorizationViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!


    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self


        // MARK: - Avtorization VK

        var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "8150318"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
//            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.68")
        ]

        guard let url = urlComponents?.url else { return }
        let requst = URLRequest(url: url)

        webView.load(requst)

    }

}

extension AuthorizationViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse:WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String:String]()) { partialResult, param in
                var dict = partialResult
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard
            let token = params["access_token"],
            let userId = params["user_id"]
        else { return }


        Session.instance.token = token
        Session.instance.userId = userId

        print("Вот токен \(Session.instance.token)")
        print("Вот userId \(Session.instance.userId)")

        decisionHandler(.cancel)

        GetApiFromVK().loadData(_parametrs: .photoFriends)
    }
    
}
