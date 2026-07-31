using {
    managed,
    cuid,
    Currency
} from '@sap/cds/common';

namespace cap.park_management;

entity VehicleTypes  : cuid, managed {
  code     : String(1);
  name     : String(50);
}

entity SlotTypes : cuid, managed {
  code : String(1);
  description : String(100);
}

entity ParkingLots : cuid, managed {
    name         : String(100);
    location     : String(200);
    totalSpots   : Integer;
    totalLevels  : Integer;
    spots        : Composition of many ParkingSpots on spots.lot = $self;
}

entity ParkingSpots : cuid, managed {
  spotNumber      : String(10);
  slotType        : Association to SlotTypes;
  level           : Integer;
  isAvailable     : Boolean default true;
  lot             : Association to ParkingLots;
  occupancy       : Association to Occupancies;
  price           : Decimal(9, 2);
  currency        : Currency;
}

entity Vehicles : cuid, managed {
  plateNumber     : String(10);
  ownerName       : String(100);
  vehicleType     : Association to VehicleTypes;
}

entity Occupancies: cuid, managed {
  orderId         : Decimal(10, 0);
  vehicle         : String(10);
  spot            : Association to ParkingSpots;
  startTime       : Timestamp;
  endTime         : Timestamp;
  active          : Boolean default true;
}