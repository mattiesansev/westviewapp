//
//  HomeViewController.swift
//  Westview App
//
//  Created by Ronak Shah on 6/8/17.
//  Copyright © 2017 Ronak Shah. All rights reserved.
//

import UIKit
import Kanna
import Alamofire
class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    var url:String?
    
    @IBOutlet var webView:UIWebView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navigationTitle: UILabel!
    var cellsAcross = 3
    var cellsDown = 2
    var horizGap = 0
    var vertGap = 0
    var html: String? = nil
    var announcements: [Announcement] = []
    
    let showAnnouncementSegueIdentifier = "ShowAnnouncementSegue"
    let textCellIdentifier = "ShowCell"
    
    @IBOutlet var announcementTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationTitle.textColor = commonColors.gold
        collectionView.contentInset = UIEdgeInsetsMake(-50, 0, 0, 0)
        navigationController?.navigationBar.barTintColor = commonColors.coolBlack
        announcementTableView.delegate = self
        announcementTableView.dataSource = self
        //whatamidoinghere?
        let url=NSURL(string:self.url!)
        webView.loadRequest(NSURLRequest(url:url! as URL) as URLRequest)
        self.scrapeAnnouncements()

    }
    // Grabs the HTML from nycmetalscene.com for parsing.
    func scrapeAnnouncements() -> Void {
        Alamofire.request("https://www.powayusd.com/en-US/Schools/HS/WVHS/HOME").responseString { response in
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
        }
    }
    func parseHTML(html: String) -> Void {
        if let doc=Kanna.HTML(html:html,encoding:String.Encoding.utf8){
            //search for nodesbyCSSselector
            for ann in doc.css("li[id^='Text']"){
                // Strip the string of surrounding whitespace.
                let annString = ann.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                // All text involving shows on this page currently start with the weekday.
                // Weekday formatting is inconsistent, but the first three letters are always there.
                let regex = try! NSRegularExpression(pattern: "^(newsitem)", options: [.caseInsensitive])
                
                if regex.firstMatch(in: annString, options: [], range: NSMakeRange(0, annString.characters.count)) != nil {
                    announcements.append(Show(text:annString)
                    print("\(annString)\n")
                }
            }
        }
        self.announcementTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //grabs the HTML from westview for parsing
//    func scrapeAnnouncements() -> Void{
//        Alamofire.request(.GET,: "https://www.powayusd.com/en-US/Schools/HS/WVHS/HOME").responseString { response in
//            print("Success: \(response.result.isSuccess)")
//            self.html = response.result.value
//            self.parseHTML(response.result.value!)
//        }
//
//
//    }
//    func parseHTML(html: String) -> Void{
//        if let doc = Kanna.HTML(html: html,encoding:String.Encoding.utf8){
//            announcements=[]
//            //searchfornoesbycss
//            for ann in doc.css("td[id^='Text']"){
//                //getheaderforannouncement
//                let header = ann.css("a").first["href"]
////                let showString=ann.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//            }
//        }
//
//    }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==showAnnouncementSegueIdentifier,
            let destination=segue.destination as? HomeViewController,
            let announcementIndex=announcementTableView.indexPathForSelectedRow?.row{
            destination.url=announcements[announcementIndex].header
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView)->Int{
        return 1
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
        cell.button.tag = indexPath.row
        cell.button.tintColor = commonColors.coolBlack
        
        //cell.button.setImage(UIImage(named: "bell")!, for: .normal)
        return cell
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.reloadData()
    }
    // Method will be called when a menu bar item is tapped
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        // decide what to do, depending on which menu button it is
        switch(sender.tag) {
        case 0:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "bellScheduleViewController") as! BellScheduleViewController
            
            self.navigationController?.pushViewController(newViewController, animated: true)
            break
        default:
            break
        }
    }
    
    
    // MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        //mattie
        //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AnnouncementTableViewCell
        cell.webView.loadHTMLString("<h1>testing</h1>", baseURL: nil)
        cell.webView.scrollView.bounces = false
        cell.webView.scrollView.isScrollEnabled = false
        let row=indexPath.row
        let announcement = announcements[row]
        cell.detailTextLabel?.text=announcement.text
        cell.textLabel?.text = announcements[row]
        return cell
    }
    
    @nonobjc func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

