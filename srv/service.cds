using {  cap.park_management as db } from '../db/schema';

service ParkingService {

  entity ParkingLots as projection on db.ParkingLots ;
  entity ParkingSpots as projection on db.ParkingSpots actions {
    action ReserveSpot(plate: String) returns Occupancies;
  };
  entity Occupancies as projection on db.Occupancies ;
  
  entity VehicleTypes as projection on db.VehicleTypes {
      ID,
      code,
      name
  };

  entity SlotTypes as projection on db.SlotTypes {
      ID,
      code,
      description
  };    
  
  entity Vehicles as projection on db.Vehicles;


  annotate ParkingSpots with {
    slotType @Common.Text: slotType.description;
    occupancy @readonly;
    price     @Measures.ISOCurrency: currency_code;
  };

  annotate Occupancies with {
    orderId   @readonly;
    startTime @UI.DateTimeStyle: 'short';
    endTime   @UI.DateTimeStyle: 'short';
  };

  annotate VehicleTypes with @cds.odata.valuelist;
  annotate SlotTypes with @cds.odata.valuelist;  
  annotate Vehicles with {
    vehicleType @Common.Text: vehicleType.name;
  };    

  action ReleaseSpot(occupancyID: UUID) returns Boolean;

}

/**
 * Service used by administrators to manage parkings .
 */
  annotate ParkingService.ParkingLots with @odata.draft.enabled;
  annotate ParkingService.Vehicles with @odata.draft.enabled;
  annotate ParkingService with @(requires: 'support');