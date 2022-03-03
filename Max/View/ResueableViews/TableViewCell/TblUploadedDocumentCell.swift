//
//  TblUploadedDocumentCell.swift
//  Max
//
//  Created by Rahul on 20/12/21.
//

import UIKit

protocol setDelegate:class {
    func cellTaped(data:String)
}

class TblUploadedDocumentCell: UITableViewCell {
    
    //MARK:-IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collDocument: UICollectionView!//W122H127
    var cellData = [ItemsData]()
    var viewModel = UploadedPrescriptionViewModel()
    weak var delegate:setDelegate?

    var date: Date = Date()
    override func awakeFromNib() {
        super.awakeFromNib()
        collDocument.delegate = self
        collDocument.dataSource = self
    }
}

extension TblUploadedDocumentCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collDocument.dequeueReusableCell(withReuseIdentifier: CollUploadedDocumentCell.identifire, for: indexPath) as? CollUploadedDocumentCell else {
            return UICollectionViewCell()
        }
        cell.imgDocument.image =  indexPath.row%2 == 0 ? #imageLiteral(resourceName: "APDF") : #imageLiteral(resourceName: "AImage")
        let dataa = viewModel.getItem(row: indexPath.row)
        cell.lblUploadedDate.text = "10 Sep 21"
        cell.lblname.text = dataa?[indexPath.row].name ?? ""

            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 122, height: 127)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataa = viewModel.getItem(row: indexPath.row)
        self.delegate?.cellTaped(data: dataa?[indexPath.row].data_id ?? "")
    }
}
