//
//  CountryPickerViewController.swift
//  SafeHouse
//
//  Created by MacMini-iOS on 02/05/19.
//  Copyright © 2019 Quytech. All rights reserved.
//

import UIKit

class CountryPickerDataSource{
    
    static let shared = CountryPickerDataSource()
    
    var countryCodeArray = [[String: String]]()
    
    private init(){
        var tempArray = [[String: String]]()
        if let path = Bundle.main.path(forResource: "CallingCodes", ofType: "plist")  {
            if let englishFromPlist = NSArray(contentsOf: URL(fileURLWithPath: path)) as? [[String: String]] {
                tempArray = englishFromPlist
            }
        }
        countryCodeArray = tempArray
    }
}

class CountryPickerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    var completion: (([String: String]) -> Void)?
    var tempArray = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tempArray = CountryPickerDataSource.shared.countryCodeArray
        self.tableView.reloadData()
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CountryPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell") as! PickerCell
        let dict = self.tempArray[indexPath.row]
        cell.flagImageView.image = UIImage(named: "\((dict["code"] ?? "").lowercased()).png")
        cell.countryCodeLabel.text = dict["dial_code"] ?? ""
        cell.countryNameLabel.text = dict["name"] ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = self.tempArray[indexPath.row]
        self.dismiss(animated: true) {
            self.completion?(dict)
        }
    }
    
}

extension CountryPickerViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filter(text: searchBar.text ?? "")
    }
    
    func filter(text: String) {
        if text.isEmpty {
            self.tempArray = CountryPickerDataSource.shared.countryCodeArray
        } else {
            let array = CountryPickerDataSource.shared.countryCodeArray.filter { (dict) -> Bool in
                return (dict["name"] ?? "").lowercased().contains(text.lowercased())
            }
            self.tempArray = array
        }
        self.tableView.reloadData()
    }
}

class PickerCell: UITableViewCell {
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        flagImageView.layer.cornerRadius = flagImageView.frame.size.width / 2.0
    }
}
