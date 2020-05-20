//
//  EventEditView.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/18.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import SwiftUI
import EventKit
import EventKitUI

struct EventKitUIView: UIViewControllerRepresentable {
    @EnvironmentObject var store: Store
    @Binding var isPresented: Bool
    @Binding var eventStore: EKEventStore
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let controller = EKEventEditViewController()
        controller.editViewDelegate = context.coordinator
        controller.event = EKEvent(eventStore: self.eventStore)
        controller.eventStore = eventStore
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: UIViewControllerRepresentableContext<EventKitUIView>) {
        
    }
    
}

class Coordinator: NSObject,UINavigationControllerDelegate, EKEventEditViewDelegate {
    
    let parent: EventKitUIView
    var eventStore = EKEventStore()
    
    init(parent: EventKitUIView) {
        self.parent = parent
    }

    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        switch action {
        case .canceled:
            print("Canceled")
        case .saved:
            print("Saved")
            do {
                try controller.eventStore.save(controller.event!, span: .thisEvent, commit: true)
                self.parent.store.dispatch(.publishEvent(requestEvent: generateRequestEvent(event: controller.event!)))
            }
            catch {
                print("Problem saving event")
            }
        case .deleted:
            print("Deleted")
        @unknown default:
            print("[ERROR]: Unknown Case Error @ EventEditView")
        }
        self.parent.isPresented = false
    }
    
    func generateRequestEvent(event: EKEvent) -> PublishEventRequest.RequestBody{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-d"
        
        let resEvent = Event(
            id: -1,
            title: event.title,
            startDate: dateFormatter.string(from: event.startDate),
            endDate: dateFormatter.string(from: event.endDate),
            location: event.location ?? "",
            url: event.url?.absoluteString ?? "",
            notes: event.notes ?? "",
            clubCode: -1,
            participant: "[]",
            openOrNot: self.parent.store.appState.eventState.newEventOpenOrNot)
        
        return PublishEventRequest.RequestBody(
            event: resEvent,
            userId: self.parent.store.appState.loginState.user?.id ?? 0)
    }
}
