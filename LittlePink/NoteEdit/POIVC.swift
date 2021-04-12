//
//  POIVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/19.
//

import UIKit

class POIVC: UIViewController, AMapLocationManagerDelegate {
    
    var delegate:POIVCDelegate?
    var poiName = ""

    let locationManager = AMapLocationManager()
    lazy  var mapSearch = AMapSearchAPI()
    lazy  var aroundSearchRequest:AMapPOIAroundSearchRequest = {
        let request = AMapPOIAroundSearchRequest()
                
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        //request.types = kPOITypes
        request.requireExtension = true
        request.offset = kPOIsOffset
        return request
    }()
    
    lazy var keywordsSearchRequest:AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.requireExtension = true
        request.keywords = keywords
        request.offset = kPOIsOffset
        return request
    }()

    lazy var footer = MJRefreshAutoNormalFooter()
    
    var pois = kPOIsInitArr
    var aroundSearchPOIs = kPOIsInitArr //完全同步周边poi数组,撤销输入后返回周边poi 
    var latitude = 0.0
    var longitude = 0.0
    var keywords = ""
    var currentAroundPage = 1
    var currentKeywordsPage = 1
    var pageCount = 1 //所有搜索的总页数

    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        requestLocation()
    }
    
}



extension POIVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as! POICell
        
        let poi = pois[indexPath.row]
        cell.poi = poi
        
        if poi[0] == poiName{
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    
}

extension POIVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark
        
        delegate?.updatePOIName(pois[indexPath.row][0])
        
        dismiss(animated: true)
    }
}


extension POIVC{
    func endRefreshing(_ currentPage : Int){
        if currentPage < pageCount{
            footer.endRefreshing()
        }else{
            footer.endRefreshingWithNoMoreData()  //不会有更多请求了 不再监听
        }
    }
}

