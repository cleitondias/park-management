using ParkingService as service from '../../srv/service';
annotate service.ParkingLots with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'location',
                Value : location,
            },
            {
                $Type : 'UI.DataField',
                Label : 'totalSpots',
                Value : totalSpots,
            },
            {
                $Type : 'UI.DataField',
                Label : 'totalLevels',
                Value : totalLevels,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>ParkingSpots}',
            ID : 'i18nParkingSpots',
            Target : 'spots/@UI.LineItem#i18nParkingSpots',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Name1}',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Location}',
            Value : location,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Totalspots}',
            Value : totalSpots,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Totallevels}',
            Value : totalLevels,
        },
    ],
    UI.SelectionFields : [
        name,
        location,
    ],
);

annotate service.ParkingLots with {
    name @Common.Label : 'name'
};

annotate service.ParkingLots with {
    location @Common.Label : 'location'
};

annotate service.ParkingSpots with @(
    UI.LineItem #i18nParkingSpots : [
        {
            $Type : 'UI.DataField',
            Value : spotNumber,
            Label : '{i18n>Spotnumber}',
        },
        {
            $Type : 'UI.DataField',
            Value : lot_ID,
            Label : '{i18n>Lotid}',
            @UI.Hidden,
        },
        {
            $Type : 'UI.DataField',
            Value : slotType_ID,
            Label : 'slotType_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : level,
            Label : 'level',
        },
        {
            $Type : 'UI.DataField',
            Value : occupancy_ID,
            Label : '{i18n>Occupancyid}',
        },
        {
            $Type : 'UI.DataField',
            Value : isAvailable,
            Label : '{i18n>Isavailable}',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'ParkingService.EntityContainer/ReleaseSpot',
            Label : '{i18n>Releasespot}',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'ParkingService.EntityContainer/ReserveSpot',
            Label : '{i18n>Reservespot}',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Spot Information',
            ID : 'SpotInformation',
            Target : '@UI.FieldGroup#SpotInformation',
        },
    ],
    UI.FieldGroup #SpotInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : spotNumber,
                Label : '{i18n>Spotnumber}',
            },
            {
                $Type : 'UI.DataField',
                Value : isAvailable,
                Label : '{i18n>Isavailable}',
            },
            {
                $Type : 'UI.DataField',
                Value : level,
                Label : '{i18n>Level}',
            },
            {
                $Type : 'UI.DataField',
                Value : slotType_ID,
                Label : '{i18n>Slottypeid}',
            },
            {
                $Type : 'UI.DataField',
                Value : occupancy_ID,
                Label : '{i18n>Occupancyid1}',
            },
        ],
    },
);

annotate service.ParkingSpots with {
    slotType @(
        Common.Text : slotType.description,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueListWithFixedValues : true,
)};

annotate service.SlotTypes with {
    ID @(
        Common.Text : description,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

