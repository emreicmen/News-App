//
//  NewsTableViewCell.swift
//  NewsAppTraining
//
//  Created by Emre İÇMEN on 6.06.2024.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsSourceImage: UIImageView!
    @IBOutlet weak var newsSourceName: UILabel!
    @IBOutlet weak var newsPublishDate: UILabel!
    @IBOutlet weak var newsCategory: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsLanguage: UILabel!
    
    private var categoryOfNew = [Category]()
    //private var categoryOfNew2: [String] = []
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        newsSourceImage.image = nil
//    }

    func setCellWithValues(_ news: News) {
        

        self.newsSourceName.text = news.sourceID?.capitalized
        self.newsPublishDate.text = news.pubDate
        self.newsDescription.text = news.title

        //self.newsLanguage.text = String(news.language)
        
        categoryOfNew = news.category ?? []
        self.newsCategory.text = "Category:\(categoryOfNew[0].rawValue)"

        if let newsImage = URL(string: "\(news.imageURL ?? "")") {
            getNewsImageData(url: URL(string: news.imageURL!)!, imageType: "")
        } else {
            self.newsImage.image = UIImage(named: "noPhoto")
        }
        
        if let newsSourceImage = URL(string: "\(news.sourceIcon ?? "")") {
            getNewsImageData(url: URL(string: news.sourceIcon!)!, imageType: "Source")
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
    
}
