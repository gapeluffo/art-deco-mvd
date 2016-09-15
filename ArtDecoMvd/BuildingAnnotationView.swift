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

}
