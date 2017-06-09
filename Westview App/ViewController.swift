//
//  ViewController.swift
//  Westview App
//
//  Created by Ronak Shah on 6/8/17.
//  Copyright © 2017 Ronak Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var cellsAcross = 3
    var cellsDown = 2
    var horizGap = 0
    var vertGap = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        collectionView.contentInset = UIEdgeInsetsMake(-50, 0, 0, 0)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.20, green:0.25, blue:0.29, alpha:1.0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsAcross * cellsDown
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(vertGap)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(horizGap)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // Compute the dimensions of a cell for a cellsAcross x cellsDown layout.
        
        let dimH = (collectionView.bounds.width - (CGFloat(cellsAcross) - 1) * CGFloat(horizGap)) / CGFloat(cellsAcross)
        
        let dimV = (collectionView.bounds.height - (CGFloat(cellsDown) - 1) * CGFloat(vertGap)) / CGFloat(cellsDown)
        
        return CGSize(width: dimH, height: dimV)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ButtonCollectionViewCell
        var image = UIImage(named: "bell")
        
        switch (indexPath.row) {
        case 0:
            image =  UIImage(named: "bell")
            break
        case 1:
            image = UIImage(named: "synergy")
            break
        case 2:
            image = UIImage(named: "calendar")
            break
        case 3:
            image = UIImage(named: "book")
            break
        case 4:
            image = UIImage(named: "phone")
            break
        case 5:
            image = UIImage(named: "myconnect")
            break
        default:
            image =  UIImage(named: "bell")
            break
            
        }
        cell.button.setImage(image!, for: .normal)
        
        cell.button.tintColor = UIColor(red:0.20, green:0.25, blue:0.29, alpha:1.0)
    
        //cell.button.setImage(UIImage(named: "bell")!, for: .normal)
        return cell
    }
    
    // MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AnnouncementTableViewCell
        cell.webView.loadHTMLString("<h1>testing</h1>", baseURL: nil)
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

