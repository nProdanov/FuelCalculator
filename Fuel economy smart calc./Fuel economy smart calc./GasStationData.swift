//
//  GasStationData.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/28/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class GasStationData: BaseGasStationData, RemoteGasStationDataDelegate
{
    var remoteData: BaseRemoteGasStationData?
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    private var delegate: GasStationDataDelegate?
    
    init(withRemoteData data: BaseRemoteGasStationData) {
        remoteData = data
        remoteData?.setDelegate(self)
        
        self.sync()
    }
    
    func setDelegate(_ delegate: GasStationDataDelegate){
        self.delegate = delegate
    }
    
    func getAll() {
        self.getAllLocal()
    }
    
    func didReceiveRemoteGasStations(_ gasStations: [GasStation]) {
        container?.performBackgroundTask { context in
            for gasStationInfo in gasStations {
                _ = try? DbModelGasStation.findOrCreateGasStation(with: gasStationInfo, in: context)
            }
            
            try? context.save()
        }
    }
    
    func didReceiveRemoteGasStationsCount(_ count: Int) {
        if let cont = self.container?.viewContext {
            cont.perform {
                if let gasStationsCount = (try? cont.count(for: DbModelGasStation.fetchRequest())) {
                    if count != gasStationsCount {
                        self.remoteData?.getAll()
                    }
                }
            }
        }
    }
    
    func didReceiveRemoteError(error: Error) {
        self.getAllLocal()
    }
    
    private func sync() {
        self.remoteData?.getAllCount()
    }
    
    private func getAllLocal(){
        if let context = self.container?.viewContext {
            context.perform { [weak self] in
                let request: NSFetchRequest<DbModelGasStation> = DbModelGasStation.fetchRequest()
                if let dbGasStations = try? context.fetch(request) {
                    let gasStations = dbGasStations.map { GasStation.fromDbModel($0) }
                    self?.delegate?.didReceiveGasStations(gasStations: gasStations)
                }
            }
        }
    }
    
    private func getAllRemote() {
        self.remoteData?.getAll()
    }
}
