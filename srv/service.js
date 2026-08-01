const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  const { ParkingSpots, ParkingLots, Vehicles, Occupancies } = this.entities;

  // Keep ParkingLots.totalSpots in sync once a lot's draft (with its spots) is saved
  this.after('SAVE', ParkingLots.drafts, async (data) => {
    const lotID = data.ID;

    const totalSpots = await SELECT.one.from(ParkingSpots).where({ lot_ID: lotID }).columns('count(*) as count');
    await UPDATE(ParkingLots).set({ totalSpots: totalSpots.count }).where({ ID: lotID });
  });

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
    const { orderId } = req.data;

    const occupancy = await SELECT.one.from(Occupancies).where({ orderId: orderId });
    

    if (!occupancy || !occupancy.active) return req.error(404, 'Occupancy not found');
    
    const spot = await SELECT.one.from(ParkingSpots).where({ occupancy_ID: occupancy.ID });
    const endTime = new Date().toISOString();
    const durationHours = Math.ceil((new Date(endTime) - new Date(occupancy.startTime)) / (1000 * 60 * 60));
    const totalPrice = durationHours * Number(spot.price);


    await UPDATE(Occupancies).set({ active: false, endTime: endTime, total: totalPrice }).where({ orderId: orderId });
    await UPDATE(ParkingSpots).set({ isAvailable: true, occupancy_ID: null }).where({ ID: occupancy.spot_ID });

    return true;
  });
});
