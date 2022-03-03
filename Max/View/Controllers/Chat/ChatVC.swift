//
//  ChatVC.swift
//  Max
//
//  Created by Ankit on 11/02/22.
//

import UIKit
import IQKeyboardManagerSwift
import CoreLocation

class ChatVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatViewBottomConstraint: NSLayoutConstraint!

    var presentation : Presentation = .push
    var tapGesture = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.scrollToRow(at: IndexPath(row: 50-1, section: 10-1) , at: .bottom, animated: false)
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        self.addKeyboardObservers()
        setupTapgesture()
    }
}

extension ChatVC {

    private func setupTapgesture()
    {
      tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.taptoHideKeybaord))
      tapGesture.numberOfTapsRequired = 1
      self.view.addGestureRecognizer(tapGesture)
      tableView.addGestureRecognizer(tapGesture)
    }

    private func addKeyboardObservers() -> Void
    {
      self.removeKeyboardObservers()
      NotificationCenter.default.addObserver(self, selector: #selector(keyBoardToBeShown), name: UIResponder.keyboardWillShowNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(keyBoardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeKeyboardObservers() -> Void
    {
      NotificationCenter.default.removeObserver(self)
    }

    private func removeTapGesture() -> Void
    {
      self.tableView.removeGestureRecognizer(self.tapGesture)
      self.view.removeGestureRecognizer(self.tapGesture)
    }

    @objc func taptoHideKeybaord(sender : UITapGestureRecognizer)
  {
    self.view.endEditing(true)

  }

    @objc private func keyBoardHide(notification:Notification) -> Void
  {
      chatViewBottomConstraint.constant = 0
//    gameTimer.invalidate()
    UIView.animate(withDuration: 0.1, animations: {
      self.view.layoutIfNeeded()
    })
  }

  @objc private func keyBoardToBeShown(notification:Notification) -> Void
  {
    if let keyboardRect = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
    {
      //49 is the height of tab bar
        chatViewBottomConstraint.constant = keyboardRect.height

      UIView.animate(withDuration: 0.1, animations: {
        self.view.layoutIfNeeded()
      })

//      if self.arrChats.count == 0 {
//        return
//      }

      self.scrollToLastCell()
    }
  }

  func scrollToLastCell() -> Void
  {
   // if self.arrChats.count == 0 {return}

    let indexPath = IndexPath(row: (50 - 1), section: 10-1)
    self.tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: true)
  }
}

extension ChatVC {

    @IBAction func backButtonAction(_ sender: UIButton){
        if presentation == .push{
        self.navigationController?.popViewController(animated: true)
        }else {
         self.dismiss(animated: true, completion: nil)
        }
    }
}

extension ChatVC : UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let senderCell: SenderCell = tableView.dequeueReusableCell(withIdentifier: "SenderCell") as! SenderCell
        let receiverCell: ReceiverCell = tableView.dequeueReusableCell(withIdentifier: "ReceiverCell") as! ReceiverCell
        if indexPath.row % 2 == 0{
       return senderCell
        }else{
        return receiverCell
        }
    }
}

extension ChatVC :  UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
      textView.isScrollEnabled = (textView.numberOfLine() > 6)
//        if textView.numberOfLine() > 6 {
//
//
//        }
    }
}

extension UITextView {
    func sizeFit(width: CGFloat) -> CGSize {
        let fixedWidth = width
        let newSize = sizeThatFits(CGSize(width: fixedWidth, height: .greatestFiniteMagnitude))
        return CGSize(width: fixedWidth, height: newSize.height)
    }

    func numberOfLine() -> CGFloat {
        let size = self.sizeFit(width: self.bounds.width)
        let numLines = floor(size.height / (self.font?.lineHeight ?? 1.0))
        return numLines
    }
}
