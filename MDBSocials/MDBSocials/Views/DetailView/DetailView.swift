//
//  DetailView.swift
//  MDBSocials
//
//  Created by Will Oakley on 3/3/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit
import MapKit

class DetailView: UIView {

    var firstBlockView: UIView!
    var mainImageView: UIImageView!
    var mapView: MKMapView!
    var getDirectionsButton: UIButton!
    
    var secondBlockView: UIView!
    var descriptionLabel: UILabel!
    var posterNameLabel: UILabel!
    
    var thirdBlockView: UIView!
    var imInterestedButton: UIButton!
    var viewInterestedButton: UIButton!
    var interestedLabel: UILabel!
    
    var fourthBlockView: UIView!
    var lyftLogo: UIImageView!
    var lyftInfoLabel: UILabel!
    
    var viewController: DetailViewController!
    
    init(frame: CGRect, controller: DetailViewController){
        super.init(frame: frame)
        viewController = controller
        setupFirstBlock()
        setupSecondBlock()
        setupThirdBlock()
        setupFourthBlock()
        mainImageView.image = viewController.post.image ?? UIImage(named: "defaultImage")
        setInterestedButtonState()
        populateLabelInfo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFirstBlock(){
        let yPos = CGFloat(85)
        firstBlockView = UIView(frame: CGRect(x: 15, y: yPos, width: self.frame.width - 30, height: 200))
        firstBlockView.backgroundColor = .MDBBlue
        firstBlockView.layer.cornerRadius = 10
        self.addSubview(firstBlockView)
        
        mainImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: firstBlockView.frame.width/2 - 20, height: firstBlockView.frame.height - 20))
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 10
        mainImageView.layer.masksToBounds = true
        firstBlockView.addSubview(mainImageView)
        
        mapView = MKMapView(frame: CGRect(x: firstBlockView.frame.width/2 + 10, y: 10, width: firstBlockView.frame.width/2 - 20, height: firstBlockView.frame.height - 70))
        mapView.mapType = .standard
        mapView.layer.cornerRadius = 10
        mapView.layer.masksToBounds = true
        firstBlockView.addSubview(mapView)
        
        let height = firstBlockView.frame.height - 30 - mapView.frame.height
        
        getDirectionsButton = UIButton(frame: CGRect(x: firstBlockView.frame.width/2 + 10, y: firstBlockView.frame.height - height - 10, width: firstBlockView.frame.width/2 - 20, height: height))
        getDirectionsButton.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        getDirectionsButton.layer.cornerRadius = 10
        getDirectionsButton.setTitle("Get Directions", for: .normal)
        getDirectionsButton.setTitleColor(.MDBBlue, for: .normal)
        getDirectionsButton.backgroundColor = .white
        getDirectionsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        firstBlockView.addSubview(getDirectionsButton)
    }
    
    func setupSecondBlock(){
        let yPos = firstBlockView.frame.minY + firstBlockView.frame.height + 20
        secondBlockView = UIView(frame: CGRect(x: 15, y: yPos , width: self.frame.width - 30, height: 90))
        secondBlockView.backgroundColor = .MDBBlue
        secondBlockView.layer.cornerRadius = 10
        self.addSubview(secondBlockView)
        
        posterNameLabel = UILabel(frame: CGRect(x: 15, y: 5, width: self.frame.width - 30, height: 30))
        posterNameLabel.textAlignment = .left
        posterNameLabel.font = UIFont(name: "Helvetica Bold", size: 18)
        
        posterNameLabel.textColor = .white
        secondBlockView.addSubview(posterNameLabel)
        
        let divider = UIView(frame: CGRect(x: 15, y: 40, width: secondBlockView.frame.width - 30, height: 3))
        divider.backgroundColor = .MDBYellow
        secondBlockView.addSubview(divider)
        
        descriptionLabel = UILabel(frame: CGRect(x: 15, y: 50, width: secondBlockView.frame.width - 30, height: 30))
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .left
        secondBlockView.addSubview(descriptionLabel)
    }
    
    func setupThirdBlock(){
        let yPos = secondBlockView.frame.minY + secondBlockView.frame.height + 20
        thirdBlockView = UIView(frame: CGRect(x: 15, y: yPos, width: self.frame.width - 30, height: 125))
        thirdBlockView.backgroundColor = .MDBBlue
        thirdBlockView.layer.cornerRadius = 10
        self.addSubview(thirdBlockView)
        
        interestedLabel = UILabel(frame: CGRect(x: 15, y: 5, width: thirdBlockView.frame.width - 30, height: 30))
        interestedLabel.textColor = .white
        thirdBlockView.addSubview(interestedLabel)
        
        let divider = UIView(frame: CGRect(x: 15, y: 40, width: thirdBlockView.frame.width - 30, height: 3))
        divider.backgroundColor = .MDBYellow
        thirdBlockView.addSubview(divider)
        
        imInterestedButton = UIButton(frame: CGRect(x: 10, y: 60, width: thirdBlockView.frame.width/2 - 20, height: 50))
        imInterestedButton.addTarget(self, action: #selector(tappedImInterested), for: .touchUpInside)
        imInterestedButton.layer.cornerRadius = 10
        imInterestedButton.titleLabel?.numberOfLines = 2
        //imInterestedButton.titleLabel?.adjustsFontSizeToFitWidth = true
        thirdBlockView.addSubview(imInterestedButton)
        
        viewInterestedButton = UIButton(frame: CGRect(x: thirdBlockView.frame.width/2 + 10, y: 60, width: thirdBlockView.frame.width/2 - 20, height: 50))
        viewInterestedButton.addTarget(self, action: #selector(tappedViewInterested), for: .touchUpInside)
        viewInterestedButton.layer.cornerRadius = 10
        viewInterestedButton.setTitle("View Interested", for: .normal)
        viewInterestedButton.setTitleColor(.MDBBlue, for: .normal)
        viewInterestedButton.backgroundColor = .white
        viewInterestedButton.titleLabel?.adjustsFontSizeToFitWidth = true
        thirdBlockView.addSubview(viewInterestedButton)
    }
    
    func setupFourthBlock(){
        let yPos = thirdBlockView.frame.minY + thirdBlockView.frame.height + 20
        fourthBlockView = UIView(frame: CGRect(x: 15, y: yPos, width: self.frame.width - 30, height: 80))
        fourthBlockView.backgroundColor = .MDBBlue
        fourthBlockView.layer.cornerRadius = 10
        self.addSubview(fourthBlockView)
        
        lyftLogo = UIImageView(frame: CGRect(x: 10, y: 10, width: fourthBlockView.frame.height - 20, height: fourthBlockView.frame.height - 20))
        lyftLogo.image = #imageLiteral(resourceName: "lyftLogo")
        fourthBlockView.addSubview(lyftLogo)
        
        lyftInfoLabel = UILabel(frame: CGRect(x: 80, y: 10, width: fourthBlockView.frame.width - 80, height: fourthBlockView.frame.height - 20))
        lyftInfoLabel.textColor = .white
        lyftInfoLabel.numberOfLines = 2
        fourthBlockView.addSubview(lyftInfoLabel)
    }
    
    func queryLyft(){
        let eventLocation = CLLocationCoordinate2DMake(viewController.post.latitude!, viewController.post.longitude!)
        if viewController.currentLocation != nil {
            LyftHelper.getRideEstimate(pickup: viewController.currentLocation!, dropoff: eventLocation) { costEstimate in
                self.lyftInfoLabel.text = "A Lyft ride will cost $" + String(describing: costEstimate.estimate!.maxEstimate.amount) + " from your location."
            }
        } else {
            print("Cant get current location")
        }
    }
    
    func populateLabelInfo(){
        descriptionLabel.text = viewController.post.description
        interestedLabel.text = "Members Interested: " + String(describing: viewController.post.getInterestedUserIds().count)
        posterNameLabel.text = "Posted By: " + viewController.post.posterName!
    }
    
    func addAnnotationToMap(){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: viewController.post.latitude!, longitude: viewController.post.longitude!)
        mapView.addAnnotation(annotation)
        mapView.setRegion(MKCoordinateRegionMake(annotation.coordinate, MKCoordinateSpanMake(0.001, 0.001)), animated: true)
    }
    
    func setInterestedButtonState(){
        var userHasSaidInterested = false
        for id in viewController.post.getInterestedUserIds() {
            if id as! String == FirebaseAuthHelper.getCurrentUser()?.uid {
                userHasSaidInterested = true
                break
            }
        }
        
        if userHasSaidInterested {
            imInterestedButton.setTitle("I'm Already Interested", for: .normal)
            imInterestedButton.setTitleColor(.darkGray, for: .normal)
            imInterestedButton.backgroundColor = .clear
            imInterestedButton.isUserInteractionEnabled = false
        }
        else{
            imInterestedButton.setTitle("I'm Interested!", for: .normal)
            imInterestedButton.setTitleColor(.MDBBlue, for: .normal)
            imInterestedButton.backgroundColor = .white
            imInterestedButton.isUserInteractionEnabled = true
        }
    }
    
    @objc func tappedImInterested(){
        FirebaseDatabaseHelper.updateInterested(postId: viewController.post.id!, userId: (FirebaseAuthHelper.getCurrentUser()?.uid)!).then { success -> Void in
            print("Updated interested")
            self.imInterestedButton.setTitle("Already Interested", for: .normal)
            self.imInterestedButton.setTitleColor(.darkGray, for: .normal)
            self.imInterestedButton.isUserInteractionEnabled = false
            self.viewController.post.addInterestedUser(userID: (FirebaseAuthHelper.getCurrentUser()?.uid)!)
            self.interestedLabel.text = "Members Interested: " + String(describing: self.viewController.post.getInterestedUserIds().count)
        }
    }
    
    @objc func getDirections(){
        let urlString = "http://maps.apple.com/?saddr=&daddr=\(viewController.post.latitude!),\(viewController.post.longitude!)"
        let url = URL(string: urlString)
        UIApplication.shared.open(url!)
    }
    
    @objc func tappedViewInterested(){
        viewController.performSegue(withIdentifier: "showInterestedUsers", sender: self)
    }
}
