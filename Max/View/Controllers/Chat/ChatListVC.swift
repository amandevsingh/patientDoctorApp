//
//  ChatListVC.swift
//  Max
//
//  Created by Ankit on 11/02/22.
//

import UIKit
enum Presentation {
    case push
    case present
}

class ChatListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    var presentation : Presentation = .push

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ChatListVC {

    @IBAction func searchButtonAction(_ sender: UIButton){
        self.view.endEditing(true)
     //hit api again

    }

    @IBAction func backButtonAction(_ sender: UIButton){
        if presentation == .push{
        self.navigationController?.popViewController(animated: true)
        }else{
        self.dismiss(animated: true, completion: nil)
        }
    }
}

extension ChatListVC : UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell") as! ChatListTableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let vc =  ChatVC.instantiate(appStoryboard: .chat) as! ChatVC
      vc.presentation = self.presentation
      present(vc, animated: true, completion: nil)
    }

}
