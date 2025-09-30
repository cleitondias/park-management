sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'vehicles/test/integration/FirstJourney',
		'vehicles/test/integration/pages/VehiclesList',
		'vehicles/test/integration/pages/VehiclesObjectPage'
    ],
    function(JourneyRunner, opaJourney, VehiclesList, VehiclesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('vehicles') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheVehiclesList: VehiclesList,
					onTheVehiclesObjectPage: VehiclesObjectPage
                }
            },
            opaJourney.run
        );
    }
);