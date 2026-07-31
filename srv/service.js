const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  const { ParkingSpots, Vehicles, Occupancies } = this.entities;

  // Reserve a spot
  this.on('ReserveSpot', ParkingSpots, async (req) => {
    const { ID: spotID } = req.params.at(-1);
    const { plate } = req.data;

    const spot = await SELECT.one.from(ParkingSpots).where({ ID: spotID });
    if (!spot || !spot.isAvailable) return req.error(400, 'Spot not available');

    //const vehicle = await SELECT.one.from(Vehicles).where({ plateNumber: plate });
    //if (!vehicle) return req.error(404, 'Vehicle not registered');

    const lastOrder = await SELECT.one.columns('orderId').from(Occupancies).orderBy('orderId desc');
    const orderId = (lastOrder?.orderId || 0) + 1;

    const occupancy = {
      ID: cds.utils.uuid(),
      orderId,
      vehicle: plate,
      spot_ID: spotID,
      startTime: new Date(),
      active: true
    };
    await INSERT.into(Occupancies).entries(occupancy);
    await UPDATE(ParkingSpots).set({ isAvailable: false, occupancy_ID: occupancy.ID }).where({ ID: spotID });

    return occupancy;
  });

  // Release a spot
  this.on('ReleaseSpot', async (req) => {
    const { occupancyID } = req.data;

    const occupancy = await SELECT.one.from(Occupancies).where({ ID: occupancyID });
    if (!occupancy || !occupancy.active) return req.error(404, 'Occupancy not found');

    await UPDATE(Occupancies).set({ active: false, endTime: new Date() }).where({ ID: occupancyID });
    await UPDATE(ParkingSpots).set({ isAvailable: true, occupancy_ID: null }).where({ ID: occupancy.spot_ID });

    return true;
  });
});
