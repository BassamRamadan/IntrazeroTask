//
//  ViewController.swift
//  IntrazeroTask
//
//  Created by Bassam on 8/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var imagesCollection: UICollectionView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var dataAvailabel: UILabel!
    
    // Create ViewModel
    var imageViewModel: ImageViewModel = {
       return ImageViewModel()
    }()
    lazy var leading: CGFloat = 20
    lazy var ratio: CGFloat = 0.25
    lazy var bounds: CGFloat = self.view.frame.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBounds(height: self.view.frame.size.height)
        initCollection()
        initViewModel()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setBounds(height: size.height)
    }
    
    func setBounds(height: CGFloat){
        self.bounds = height
        if UIDevice.current.orientation.isLandscape {
            self.ratio = 0.4
        } else {
            self.ratio = 0.25
        }
    }
    
    private func initCollection(){
        imagesCollection.delegate = self
        imagesCollection.dataSource = self
    }
    private func initViewModel(){
        imageViewModel.imageArray.bind { [weak self] (data) in
            DispatchQueue.main.async {
                self?.dataAvailabel.isHidden = data?.isEmpty == false
                self?.imagesCollection.reloadData()
            }
        }
        imageViewModel.state.bind { [weak self] (state) in
            guard let self = self else{
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else{
                    return
                }
                switch state{
                case .empty,.error:
                    self.indicatorView.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.imagesCollection.alpha = 0.0
                    })
                case .loading:
                    self.indicatorView.startAnimating()
                case .populated:
                    self.indicatorView.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.imagesCollection.alpha = 1
                    })
                case .none:
                    print("")
                }
            }
        }
        
        imageViewModel.alertMessage.bind { (message) in
            guard let message = message else{
                return
            }
            DispatchQueue.main.async { [self] in
                self.present(makeAlert(message: message), animated: true, completion: nil)
            }
        }
        
        imageViewModel.fechData()
    }
    
    // Create Error Handler Alert
    private func makeAlert( message: String) -> UIAlertController{
        let alert = UIAlertController(title: "Alert", message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default,.cancel,.destructive:
                print("default")
            @unknown default:
                print("default")
            }}))
        return alert
    }
    
    // Check if row is Ads
    private func isAds(at: IndexPath) -> Bool{
        return  ((at.row+1)%6 == 0)
    }
    
    // Segue to image Details View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageDetails"{
            if let dest = segue.destination as? imageDetailsViewController{
                dest.imageInfo = sender as? imageModel
            }
        }
    }
}
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageViewModel.numberOfRowsInSection(section: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("bouns = \(bounds) -- ratio = \(ratio)")
        return .init(width: imagesCollection.frame.width - 2 * leading, height: (isAds(at: indexPath) ? 80 : ratio*bounds))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // every 5 items i set ads view between them
        if isAds(at: indexPath){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ads", for: indexPath)
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "images", for: indexPath) as? imageCell else {return UICollectionViewCell()}
        let data = imageViewModel.cellForRowAt(indexPath: indexPath)
        
        // Check if App is Online or Offline to determine of calling api or load data from SQLite Database
        if Connectivity.isConnectedToInternet{
            cell.image.sd_setImage(with: URL(string: data.downloadURL ?? "")) { [weak self] (image, error, imageCachType, url) in
                cell.addImageGradient()
                DispatchQueue.global().async {
                    if image?.pngData() != nil{
                        self?.imageViewModel.insertRow(imageModel(id: data.id, author: data.author, downloadURL: data.downloadURL))
                        
                    }
                }
            }
            if indexPath.row + 1 == imageViewModel.numberOfRowsInSection(section: 0){
                imageViewModel.fechData()
            }
        }else{
            //cell.image.image = UIImage(data: data.photo ?? Data())
            cell.image.sd_setImage(with: URL(string: data.downloadURL ?? ""))
        }
        cell.author.text = data.author ?? ""    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: leading, bottom: 0, right: leading)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isAds(at: indexPath) == false{
            performSegue(withIdentifier: "imageDetails", sender:  imageViewModel.cellForRowAt(indexPath: indexPath))
        }
    }
}

