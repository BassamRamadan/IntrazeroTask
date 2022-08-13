//
//  imageViewModel.swift
//  IntrazeroTask
//
//  Created by Bassam on 8/12/22.
//

import Foundation
import SDWebImage

class ImageViewModel {
    private var pageNamber: Int
    var imageArray = Blindable<[imageModel]>()
    var state = Blindable<State>()
    var alertMessage = Blindable<String>()
    var presentRowsIsFull = false
    
    init() {
        pageNamber = 0
        connectToDatabase()
        createTable()
    }
   
    
    private func connectToDatabase() {
        _ = SQLiteDatabase.sharedInstance
    }
    private func createTable(){
        SQLiteDatabase.sharedInstance.createTable()
    }
    
    private func fechImagesFromSQLiteDatabase() {
        imageArray.value = SQLiteCommands.presentRows() ?? []
    }
    
    private func fetchImagesFromAPI() {
        state.value = .loading
        pageNamber += 1
        DispatchQueue.global().async {
            AlamofireRequests.getMethod(url: "https://picsum.photos/v2/list?page=\(self.pageNamber)&limit=10", headers: [:])
            { [weak self] (error, response, data) in
                guard let self = self else {
                    return
                }
                guard error == nil else{
                    self.state.value = .error
                    self.alertMessage.value = error?.localizedDescription
                    return
                }
                do{
                    let decoder = JSONDecoder()
                    let picInfo = try decoder.decode([imageModel].self, from: data)
                    self.state.value = .populated
                    if self.imageArray.value?.isEmpty == true{
                        self.imageArray.value = [] + picInfo
                    }
                    var combine = self.imageArray.value ?? []
                    combine += picInfo
                    self.imageArray.value = combine
                }catch{
                    self.state.value = .error
                    self.alertMessage.value = "حدث خطأ بالرجاء التاكد من اتصالك بالانترنت "
                }
            }
        }
    }
    
    func fechData(){
        if Connectivity.isConnectedToInternet{
            fetchImagesFromAPI()
        }else{
            fechImagesFromSQLiteDatabase()
        }
    }
    
    func numberOfRowsInSection (section: Int) -> Int {
        if imageArray.value?.count != 0 {
            return imageArray.value?.count ?? 0
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> imageModel {
        return imageArray.value![indexPath.row]
    }
    
    func insertRow(_ data: imageModel){
        if presentRowsIsFull {
            return
        }
        if (SQLiteCommands.presentRows() ?? []).count < 20{
            _ = SQLiteCommands.insertRow(data)
        }else{
            presentRowsIsFull = true
        }
    }
}
