//
//  TagCollection.swift
//  Max
//
//  Created by Rahul on 16/12/21.
//

import UIKit

class TagCollection: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionTag: UICollectionView!
    
    var arrData: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("TagCollection", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .red
        initCollectionView()
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: CollTag.identifire, bundle: nil)
        collectionTag.register(nib, forCellWithReuseIdentifier: CollTag.identifire)
        collectionTag.dataSource = self
        collectionTag.delegate = self
    }
}

extension TagCollection: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionTag.dequeueReusableCell(withReuseIdentifier: CollTag.identifire, for: indexPath) as? CollTag else {
            return UICollectionViewCell()
        }
        cell.lblInfo.text = arrData[indexPath.row]
        if indexPath.row == 0 {
            cell.lblInfo.textColor = #colorLiteral(red: 0.5411764706, green: 0.6156862745, blue: 0.7137254902, alpha: 1)
            cell.lblInfo.backgroundColor = #colorLiteral(red: 0.5411764706, green: 0.6156862745, blue: 0.7137254902, alpha: 0.1)
        }else {
            cell.lblInfo.textColor = #colorLiteral(red: 0.3529411765, green: 0.7254901961, blue: 0.7058823529, alpha: 1)
            cell.lblInfo.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.7254901961, blue: 0.7058823529, alpha: 0.2)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = arrData[indexPath.row].widthOfString(usingFont: UIFont.systemFont(ofSize: 12)) + 14
        return CGSize(width: width, height: 24)
    }
}
