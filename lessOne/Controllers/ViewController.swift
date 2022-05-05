//
//  ViewController.swift
//  lessOne
//
//  Created by Евгений Ефименко on 01.02.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonEntry: UIButton!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var theThirdView: UIView!

    // MARK: - Animation

    let fromEntryTabBarSegue = "fromEntryTabBarSegue"

    //    func loadAnimate(currentCount: Int, totalCount: Int) {
    //
    //        firstView.alpha = 1
    //        secondView.alpha = 0
    //        theThirdView.alpha = 0
    //
    //        UIView.animate(withDuration: 1) {[weak self] in
    //            self?.firstView.alpha = 0
    //            self?.secondView.alpha = 1
    //        } completion: { _ in
    //            UIView.animate(withDuration: 1) {[weak self] in
    //                self?.secondView.alpha = 0
    //                self?.theThirdView.alpha = 1
    //            } completion: { _ in
    //                UIView.animate(withDuration: 1) {[weak self] in
    //                    self?.theThirdView.alpha = 0
    //                    self?.firstView.alpha = 1
    //                } completion: { [weak self] _ in
    //                    if currentCount + 1 <= totalCount {
    //                        self?.loadAnimate(currentCount: currentCount + 1, totalCount: totalCount)
    //                        self?.loginTextField.text = String (currentCount + 1)
    //                    }
    //                    else {return}
    //                }
    //            }
    //        }
    //    }
    //
    //    func animateDelay(currentCount: Int, totalCount: Int) {
    //        firstView.alpha = 1
    //        secondView.alpha = 0
    //        theThirdView.alpha = 0
    //
    //        UIView.animate(withDuration: 1,
    //                       delay: 0,
    //                       options: [],
    //                       animations: { [weak self] in
    //            self?.firstView.alpha = 0
    //            self?.secondView.alpha = 1
    //        }, completion: nil)
    //        UIView.animate(withDuration: 1,
    //                       delay: 1,
    //                       options: [],
    //                       animations: { [weak self] in
    //            self?.secondView.alpha = 0
    //            self?.theThirdView.alpha = 1
    //        }, completion: nil)
    //        UIView.animate(withDuration: 1,
    //                       delay: 2,
    //                       options: [],
    //                       animations: { [weak self] in
    //            self?.secondView.alpha = 0
    //            self?.theThirdView.alpha = 1
    //        }, completion: { [weak self] _ in
    //            if currentCount + 1 <= totalCount {
    //                self?.animateDelay(currentCount: currentCount + 1, totalCount: totalCount)
    //                self?.loginTextField.text = String (currentCount + 1)
    //            }
    //            else {return}
    //        })
    //    }
    func animateKeyFrame(currentCount: Int, totalCount: Int) {

        firstView.alpha = 1
        secondView.alpha = 0
        theThirdView.alpha = 0

        UIView.animateKeyframes(withDuration: 3, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.3) { [weak self] in
                self?.firstView.alpha = 0
                self?.secondView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3,
                               relativeDuration: 0.3) { [weak self] in
                self?.secondView.alpha = 0
                self?.theThirdView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6,
                               relativeDuration: 0.4) { [weak self] in
                self?.secondView.alpha = 0
                self?.theThirdView.alpha = 1
            }

        } completion: { [weak self] _ in
            if currentCount + 1 <= totalCount {
                self?.animateKeyFrame(currentCount: currentCount + 1, totalCount: totalCount)
                //                self?.loginTextField.text = String (currentCount + 1)
            }
            else {return}
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        loadAnimate(currentCount: 1, totalCount: 3)
        //        animateDelay(currentCount: 1, totalCount: 3)
        animateKeyFrame(currentCount: 1, totalCount: 3)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: -

        let clickScreen = UITapGestureRecognizer(target: self, action: #selector(clickTap))
        self.view.addGestureRecognizer(clickScreen)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_ : )),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_ : )),
                                               name: UIResponder.keyboardDidHideNotification, object: nil)
        buttonEntry.layer.cornerRadius = 50
        buttonEntry.layer.shadowColor = UIColor.black.cgColor
        buttonEntry.layer.shadowOffset = CGSize(width: 5, height: 5)
        buttonEntry.layer.shadowRadius = 3
        buttonEntry.layer.shadowOpacity = 0.8

    }

    @IBAction func unwindHomeToViewController(segue: UIStoryboardSegue) {

    }

    @objc func keyboardShow(_ notification: Notification) {
        let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        guard let keyboardHeight = keyboardSize?.height else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset

    }

    @objc func keyboardHide(_ notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero

    }

    @objc func clickTap() {
        self.view.endEditing(true)

    }

    @IBAction func loginButtonEntry(_ sender: Any) {
        guard let login = self.loginTextField.text,
              login == "" ,
              let password = self.passwordTextField.text,
              password == ""
        else {
            print("error")
            return
        }
        performSegue(withIdentifier: fromEntryTabBarSegue, sender: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

