using {  cap.park_management as db } from '../db/schema';

service ParkingService {

  entity ParkingLots as projection on db.ParkingLots ;
  entity ParkingSpots as projection on db.ParkingSpots ;
  entity Vehicles as projection on db.Vehicles;
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

  entity Occupancies as projection on db.Occupancies ;

  annotate VehicleTypes with @cds.odata.valuelist;
  annotate SlotTypes with @cds.odata.valuelist;

  annotate ParkingSpots with {
    slotType @Common.Text: slotType.description;
    occupancy @readonly;
  };

  annotate Vehicles with {
    vehicleType @Common.Text: vehicleType.name;
  };

  action ReserveSpot(spotID: UUID, plate: String) returns Occupancies;
  action ReleaseSpot(occupancyID: UUID) returns Boolean;  

}

  annotate ParkingService.Vehicles with @odata.draft.enabled;
  annotate ParkingService.ParkingLots with @odata.draft.enabled;
  annotate ParkingService.Occupancies with @odata.draft.enabled;