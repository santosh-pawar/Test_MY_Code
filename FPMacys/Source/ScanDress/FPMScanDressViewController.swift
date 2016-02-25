//
//  FPMScanDressViewController.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/6/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class FPMScanDressViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var highlightView: UIView = UIView()
    
    private enum ScanDressError: ErrorType {
        case InvalidInput(error:String)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highlightView.autoresizingMask = [.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleLeftMargin, .FlexibleRightMargin]
        // Select the color for the completed scan reticle
        highlightView.layer.borderColor = UIColor.greenColor().CGColor
        highlightView.layer.borderWidth = 3
        
        // Add it as a subview to the controller's view.
        view.addSubview(self.highlightView)
        
        // For the sake of discussion this is the camera
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do {
            guard let input: AVCaptureDeviceInput? = try AVCaptureDeviceInput(device: device) else {
                throw ScanDressError.InvalidInput(error: "Invalid input device")
            }
            session.addInput(input)
        } catch ScanDressError.InvalidInput(let error) {
            debugPrint("Invalid input device = \(error)!!!")
        } catch {
            debugPrint("Something went wrong while capturing the input!!!")
        }
        
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        session.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session) as AVCaptureVideoPreviewLayer
        previewLayer.frame = self.view.bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(previewLayer)
        
        session.startRunning()
    }
    
    // This is called when we find a known barcode type with the camera.
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        var highlightViewRect = CGRectZero
        
        var barCodeObject : AVMetadataObject!
        
        var detectionString : String!
        
        let barCodeTypes = [AVMetadataObjectTypeUPCECode,
            AVMetadataObjectTypeCode39Code,
            AVMetadataObjectTypeCode39Mod43Code,
            AVMetadataObjectTypeEAN13Code,
            AVMetadataObjectTypeEAN8Code,
            AVMetadataObjectTypeCode93Code,
            AVMetadataObjectTypeCode128Code,
            AVMetadataObjectTypePDF417Code,
            AVMetadataObjectTypeQRCode,
            AVMetadataObjectTypeAztecCode
        ]
        
        // The scanner is capable of capturing multiple 2-dimensional barcodes in one scan.
        for metadata in metadataObjects {
            
            for barcodeType in barCodeTypes {
                
                if metadata.type == barcodeType {
                    barCodeObject = self.previewLayer.transformedMetadataObjectForMetadataObject(metadata as! AVMetadataMachineReadableCodeObject)
                    
                    highlightViewRect = barCodeObject.bounds
                    
                    detectionString = (metadata as! AVMetadataMachineReadableCodeObject).stringValue
                    
                    self.session.stopRunning()
                    break
                }
                
            }
        }
        
        print(detectionString)
        self.highlightView.frame = highlightViewRect
        self.view.bringSubviewToFront(self.highlightView)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        navigationController?.navigationBarHidden = false
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBarHidden = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSNotificationCenter.defaultCenter().postNotificationName(kDismissSearchTextField, object: nil)
    }

    
}