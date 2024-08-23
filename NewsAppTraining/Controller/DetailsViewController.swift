//
//  DetailsViewController.swift
//  NewsAppTraining
//
//  Created by Emre İÇMEN on 6.06.2024.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsSourceImage: UIImageView!
    @IBOutlet weak var newsSourceName: UILabel!
    @IBOutlet weak var newReleaseDate: UILabel!
    @IBOutlet weak var newsCategory: UILabel!
    @IBOutlet weak var newsLanguage: UILabel!
    @IBOutlet weak var newDetails: UILabel!
    @IBOutlet weak var newsHeader: UILabel!
    @IBOutlet weak var newsLink: UILabel!
    
    var selectedNew: News?
    private var categoryOfNew = [Category]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped))
        newsLink.isUserInteractionEnabled = true
        newsLink.addGestureRecognizer(tapGesture)
        
        self.newsLink.text = selectedNew?.link
        self.newsHeader.text = selectedNew?.title
        self.newsSourceName.text = selectedNew?.sourceID?.capitalized
        self.newReleaseDate.text = selectedNew?.pubDate
        self.newDetails.text = selectedNew?.description

        self.newsLanguage.text = selectedNew?.language?.rawValue
        
        categoryOfNew = selectedNew?.category ?? []
        self.newsCategory.text = "Category:\(categoryOfNew[0].rawValue.capitalized)"

        if let _ = URL(string: "\(selectedNew?.imageURL ?? "")") {
            getNewsImageData(url: URL(string: selectedNew?.imageURL! ?? "")!, imageType: "")
        } else {
            self.newsImage.image = UIImage(named: "noPhoto")
        }
        
        if let _ = URL(string: "\(selectedNew?.sourceIcon ?? "")") {
            getNewsImageData(url: URL(string: selectedNew?.sourceIcon! ?? "")!, imageType: "Source")
        }else{
            self.newsSourceImage.image = UIImage(named: "noPhoto")
        }

    }
    

    private func getNewsImageData(url: URL, imageType: String?) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
            }
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            guard let data = data else {
                print("Empty data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data){
                    if imageType != "" {
                        self.newsSourceImage.image = image
                    }else {
                        self.newsImage.image = image
                    }
                }
            }
        }.resume()
    }
    
    @objc func labelTapped() {
        if let url = URL(string: String(selectedNew?.link ?? "")) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
}
