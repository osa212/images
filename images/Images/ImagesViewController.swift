//
//  ViewController.swift
//  images
//
//  Created by osa on 21.09.2021.
//

import UIKit

class ImagesViewController: UITableViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var isLoading = true
    
    var viewModel: ImagesViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
   
    private func initialize() {
        activityIndicator.startAnimating()
        
        viewModel = ImagesViewModel()
        viewModel.getPictures { [unowned self] in
            if self.viewModel.pictures.count >= 10 {
                self.isLoading = false
            }
            self.tableView.reloadData()
            
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isLoading ? 1 : viewModel.pictures.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            return tableView.dequeueReusableCell(withIdentifier: "activity", for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

            let keysArray = Array(viewModel.pictures.keys)
            let valuesArray = Array(viewModel.pictures.values)
            let currentKey = keysArray[indexPath.row]
            let currentValue = valuesArray[indexPath.row]
            
            cell.textLabel?.text = currentKey.author
            cell.imageView?.image = UIImage(data: currentValue)
                  
            return cell
        }
        
        
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let lastPicture = viewModel.pictures.count - 1
            if indexPath.row == lastPicture && viewModel.pictures.count >= 10 {
                viewModel.page.value += 1
                viewModel.page.bind { [unowned self] _ in
                    self.viewModel.getPictures {
                        tableView.reloadData()
                    }
                }
            }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let detailVC = segue.destination as? DetailViewController
        detailVC?.viewModel = viewModel.detailViewModelInit(indexPath: indexPath)
    }
}


