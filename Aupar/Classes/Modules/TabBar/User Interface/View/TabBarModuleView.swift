//
//  TabBarModuleView.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation
import UIKit

class TabBarModuleView: UITabBarController, UITabBarControllerDelegate, TabBarModuleViewProtocol{
    var presenter: TabBarModulePresenterProtocol?
    struct Platform {
        static var isSimulator: Bool {
            return TARGET_OS_SIMULATOR != 0
        }
    }
    var selector: UIView?
    var icon: UIImageView?
    var loaded = false
    var locationModal:Bool = false
    var registerCheck:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor.white
        } else {
            // Fallback on earlier versions
        }
        self.selectedIndex = 2
        let itemWidth = self.view.frame.size.width / 5
        let itemHeight = self.tabBar.frame.size.height + 15 + 4
        self.selector = UIView(frame: CGRect(x: (itemWidth * CGFloat(self.selectedIndex)) , y: (self.view.frame.size.height - itemHeight + 4), width: itemWidth, height: itemHeight))
        self.selector!.backgroundColor = UIColor.white
        
        let radius: CGFloat = self.selector!.frame.height / 2.0 //change it to .height if you need spread for height
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.selector!.frame.width, height: 2.1 * radius))
        
        self.selector!.layer.cornerRadius = 4
        self.selector!.layer.shadowColor = UIColor.black.cgColor
        self.selector!.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        self.selector!.layer.shadowOpacity = 0.5
        self.selector!.layer.masksToBounds =  false
        self.selector!.layer.shadowPath = shadowPath.cgPath
        
        let selectedItem:UITabBarItem = self.tabBar.items![self.selectedIndex]
        icon = UIImageView(frame: CGRect(x: 15, y: 15, width: (self.selector!.frame.width - 30), height: (self.selector!.frame.height - 30)))
        
        icon!.image = selectedItem.image!.withRenderingMode(.alwaysTemplate)
        icon!.tintColor = Utilities.shared.naranja
        icon!.contentMode = .scaleAspectFit
        self.selector!.addSubview(icon!)
        self.view.addSubview(self.selector!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkSlider()
        
    }
    func checkSlider(){
        if #available(iOS 11.0, *) {
            if !loaded{
                if let sel = self.selector{
                    self.selector?.frame = CGRect(x: sel.frame.minX, y: sel.frame.minY - view.safeAreaInsets.bottom, width: sel.frame.width, height: sel.frame.height + view.safeAreaInsets.bottom)
                    loaded = true
                }
                
            }
        }
    }
    
    func updateSlider(){
        let itemWidth = self.view.frame.size.width / 5
        let itemHeight = self.tabBar.frame.size.height + 15 + 4
        self.selector?.frame = CGRect(x: (itemWidth * CGFloat(self.selectedIndex)) , y: (self.view.frame.size.height - itemHeight + 4), width: itemWidth, height: itemHeight)
        self.checkSlider()
    }
    
    func updateSliderValue(value:Int){
        let selectedItem:UITabBarItem = self.tabBar.items![value]
        self.changeItem(item: selectedItem)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        return UIColor.init(red: 251.0, green: 105.0, blue: 0.0, alpha: 1)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let itemWidth = self.view.frame.size.width / 5
        let itemFinalXposition = (itemWidth * CGFloat(self.tabBar.items!.firstIndex(of: item)!)) + (itemWidth/2);
        UIView.animate(withDuration: 0.5, animations:{
            self.selector!.center.x = itemFinalXposition
        })
        UIView.animate(withDuration: 0.25, animations:{
            self.icon!.alpha = 0
        }, completion:{ finished in
            self.icon!.image = item.image!.withRenderingMode(.alwaysTemplate)
            self.icon!.tintColor = Utilities.shared.naranja
            self.icon!.contentMode = .scaleAspectFit
            UIView.animate(withDuration: 0.25, animations:{
                self.icon!.alpha = 1
            })
            
        })
    }
    
    func changeItem(item: UITabBarItem){
        let itemWidth = self.view.frame.size.width / 5
        let itemFinalXposition = (itemWidth * CGFloat(self.tabBar.items!.firstIndex(of: item)!)) + (itemWidth/2);
        UIView.animate(withDuration: 0.5, animations:{
            self.selector!.center.x = itemFinalXposition
        })
        UIView.animate(withDuration: 0.25, animations:{
            self.icon!.alpha = 0
        }, completion:{ finished in
            self.icon!.image = item.image!.withRenderingMode(.alwaysTemplate)
            self.icon!.tintColor = Utilities.shared.naranja
            self.icon!.contentMode = .scaleAspectFit
            UIView.animate(withDuration: 0.25, animations:{
                self.icon!.alpha = 1
            })
        })
    }
}
