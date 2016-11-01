//
//  BuildingAnnotationView.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 9/7/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit
import MapKit

class BuildingAnnotationView: MKAnnotationView{

    private var calloutView: BuildingView?
    private var hitOutside:Bool = true

    convenience init(annotation:MKAnnotation!) {
        self.init(annotation: annotation, reuseIdentifier: "pin")

        canShowCallout = false;
    }

    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {

        let hitView = super.hitTest(point, withEvent: event)

        if (hitView != nil)
        {
            self.superview?.bringSubviewToFront(self)
        }
        
        return hitView;
        
    }

    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {

        let rect = self.bounds
        var isInside = CGRectContainsPoint(rect, point)

        if(!isInside) {
            for view in self.subviews {

                isInside = CGRectContainsPoint(view.frame, point)
                break;
            }
        }
        
        return isInside
    }

    
}
