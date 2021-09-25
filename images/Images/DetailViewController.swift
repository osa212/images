//
//  DetailViewController.swift
//  images
//
//  Created by osa on 21.09.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var viewModel: DetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
    
    private func initialize() {
        imageView.image = UIImage(data: viewModel.image)
        nameLabel.text = viewModel.picture.author
    }
    

}
