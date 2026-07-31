using ParkingService as service from '../../srv/service';
annotate service.Vehicles with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'plateNumber',
                Value : plateNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ownerName',
                Value : ownerName,
            },
            {
                $Type : 'UI.DataField',
                Value : vehicleType_ID,
                Label : 'vehicleType_ID',
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
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'plateNumber',
            Value : plateNumber,
        },
        {
            $Type : 'UI.DataField',
            Label : 'ownerName',
            Value : ownerName,
        },
        {
            $Type : 'UI.DataField',
            Value : vehicleType_ID,
            Label : 'vehicleType_ID',
        },
    ],
);

annotate service.Vehicles with {
    vehicleType @(
        Common.ValueListWithFixedValues : true,
        Common.Text : vehicleType.name,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ExternalID : vehicleType.name,
    )
};

annotate service.VehicleTypes with {
    ID @Common.Text : name
};

annotate service.VehicleTypes with {
    code @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

