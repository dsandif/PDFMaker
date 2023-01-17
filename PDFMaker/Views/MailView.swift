//
//  MailView.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 1/17/23.
//

import Foundation
import MessageUI
import SwiftUI



struct MailView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MFMailComposeViewController
    
    var subject: String
    var recipients: [String]
    var content: String
    var attachments: [String]
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        if MFMailComposeViewController.canSendMail(){
            let view = MFMailComposeViewController()
            view.mailComposeDelegate = context.coordinator
            view.setToRecipients(recipients)
            view.setSubject(subject)
            view.setMessageBody(content, isHTML: false)
//            view.addAttachmentData()
            return view
        }else{
            return MFMailComposeViewController()
        }
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate{
        var parent: MailView
        
        init(_ parent: MailView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) -> Void {
            controller.dismiss(animated: true)
        }
    }

}
