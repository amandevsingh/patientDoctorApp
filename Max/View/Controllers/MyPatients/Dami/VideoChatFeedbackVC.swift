//
//  VideoChatFeedbackVC.swift
//  Biocon
//
//  Created by Satyam Kumar on 01/03/22.
//  Copyright © 2022 Twilio. All rights reserved.
//

import UIKit
import SwiftUI

class VideoChatFeedbackVC: UIViewController {

    @IBOutlet weak var audioIssueTbView: UITableView!
    @IBOutlet weak var videoIssueTbView:UITableView!
    @IBOutlet weak var  audioIssueTbViewHeight: NSLayoutConstraint!
    @IBOutlet weak var videoIssueTbViewHeight: NSLayoutConstraint!
    @IBOutlet weak var feedbackTxtView:UITextView!
    var audioBolValue:[Bool] = []
    var videoBolValue:[Bool] = []
}
//MARK: - Life Cycle
extension VideoChatFeedbackVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackTxtView.delegate = self
        feedbackTxtView.layer.borderWidth = 1
        feedbackTxtView.layer.borderColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        audioIssueTbView.register(UINib(nibName: "AudioIssueTbCell", bundle: nil), forCellReuseIdentifier: "AudioIssueTbCell")
        videoIssueTbView.register(UINib(nibName: "VideoIssueTbCell", bundle: nil), forCellReuseIdentifier: "VideoIssueTbCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillingBoolValue(value:false)
        self.audioIssueTbView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.videoIssueTbView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.audioIssueTbView.removeObserver(self, forKeyPath: "contentSize")
        self.videoIssueTbView.removeObserver(self, forKeyPath: "contentSize")
       
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if let obj = object as? UIScrollView {
            if obj == self.audioIssueTbView && keyPath == "contentSize" {
                if let newvalue = change?[.newKey]{
                    let newsize  = newvalue as! CGSize
                    self.audioIssueTbViewHeight.constant = newsize.height
                }
            }else if obj == self.videoIssueTbView && keyPath == "contentSize" {
                if let newvalue = change?[.newKey]{
                    let newsize  = newvalue as! CGSize
                    self.videoIssueTbViewHeight.constant = newsize.height
                }
            }
        }
    }
    func fillingBoolValue(value:Bool)
    {
        audioBolValue.removeAll()
        for _ in 0..<3{
            self.audioBolValue.append(value)
        }
        videoBolValue.removeAll()
        for _ in 0..<3{
            self.videoBolValue.append(value)
        }
    }
}
//MARK: - IBAction
extension VideoChatFeedbackVC{
    
}
//MARK: - TableView Delegate
extension VideoChatFeedbackVC:UITableViewDelegate{
    
}
//MARK: - TableView Data Source
extension VideoChatFeedbackVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == audioIssueTbView{
            return 3
        }
        return 3
        
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == audioIssueTbView{
            let cell = audioIssueTbView.dequeueReusableCell(withIdentifier: "AudioIssueTbCell") as! AudioIssueTbCell
            
            if audioBolValue[indexPath.row]
            {
                cell.checkImage.image = UIImage(named: "checkbox")
            }else{
                cell.checkImage.image = UIImage(named: "Rectangle")
    
            }
           
            return cell
        }
       
        let cell = videoIssueTbView.dequeueReusableCell(withIdentifier: "VideoIssueTbCell") as! VideoIssueTbCell
        if videoBolValue[indexPath.row]
        {
            cell.checkImage.image = UIImage(named: "checkbox")
        }else{
            cell.checkImage.image = UIImage(named: "Rectangle")

        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == audioIssueTbView
        {
            if audioBolValue[indexPath.row]{
                audioBolValue[indexPath.row] = false
            }else{
                audioBolValue[indexPath.row] = true
            }
        audioIssueTbView.reloadData()
        }
        else if tableView == videoIssueTbView{
            if videoBolValue[indexPath.row]{
                videoBolValue[indexPath.row] = false
            }else{
                videoBolValue[indexPath.row] = true
            }
            videoIssueTbView.reloadData()
        }
    }
    
    
}
extension VideoChatFeedbackVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (feedbackTxtView.text == "Tell us about your experience...")
        {
            feedbackTxtView.text = nil
            feedbackTxtView.textColor = #colorLiteral(red: 0.1051146612, green: 0.3041367531, blue: 0.5033302307, alpha: 1)
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if feedbackTxtView.text.isEmpty
        {
            feedbackTxtView.text = "Tell us about your experience..."
            feedbackTxtView.textColor = #colorLiteral(red: 0.1051146612, green: 0.3041367531, blue: 0.5033302307, alpha: 1)
        }
        textView.resignFirstResponder()
    }
}
