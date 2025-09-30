sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'parkinglot/test/integration/FirstJourney',
		'parkinglot/test/integration/pages/ParkingLotsList',
		'parkinglot/test/integration/pages/ParkingLotsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ParkingLotsList, ParkingLotsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('parkinglot') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheParkingLotsList: ParkingLotsList,
					onTheParkingLotsObjectPage: ParkingLotsObjectPage
                }
            },
            opaJourney.run
        );
    }
);