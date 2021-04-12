//
//  POIVC-KeywordsSearch.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/25.
//

extension POIVC:UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {dismiss(animated: true)}
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            pois = aroundSearchPOIs
            setAroundSearchFooter()
            tableview.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //每次发起搜索都需要重置,pois、currentKeywordsPage重置和footer控件重置
        guard let searchText = searchBar.text ,!searchText.isBlank else{ return }
        keywords = searchText
        pois.removeAll()
        currentKeywordsPage = 1
        setKeywordsSearchFooter()
        showLoadHUD()
        makeKeywordsSearch(keywords)
        //searchBar.resignFirstResponder()
    }
}


//所有搜索api的回调
extension POIVC : AMapSearchDelegate{
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        let poiCount = response.count
        hideLoadHUD()
        
        if poiCount > kPOIsOffset{
            pageCount = response.count / kPOIsOffset + 1
        }else{
            footer.endRefreshingWithNoMoreData()
        }
        
        if poiCount == 0 {
            return
        }
        
        for poi in response.pois{
            //            poi.name
            let province =  poi.province == poi.city ? "" : poi.province
            //偏远地区
            let address = poi.district == poi.address ? "" : poi.address
            
            let poi = [
                poi.name ?? kNoPOIPH,
                "\(province.unwrappedText)\(poi.city.unwrappedText)\(poi.district.unwrappedText)\(address.unwrappedText)"]
            
            pois.append(poi)
            if request is AMapPOIAroundSearchRequest{
                aroundSearchPOIs.append(poi)
            }
        }
        
        
        tableview.reloadData()
    }
}

extension POIVC{
    private func makeKeywordsSearch(_ keywords :String, _ page:Int = 1){
        keywordsSearchRequest.keywords = keywords
        keywordsSearchRequest.page = page
        mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)
    }
    private func setKeywordsSearchFooter(){
        footer.resetNoMoreData()
        footer.setRefreshingTarget(self, refreshingAction: #selector(keywordsSearchPullToRefresh))
    }
}

//关键字下拉刷新
extension POIVC{
    @objc private func keywordsSearchPullToRefresh(){
        currentKeywordsPage += 1
        makeKeywordsSearch(keywords,currentKeywordsPage)
        endRefreshing(currentKeywordsPage)
    }
}


