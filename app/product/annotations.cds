using CatalogService as service from '../../srv/catalog-service';

annotate service.Products with @(

    UI.SelectionFields : [
        ToCategory_ID,
        ToCurrency_ID,
        StockAvailability
    ],

    UI.LineItem        : [
        {
            $Type : 'UI.DataField',
            Label : 'ImageUrl',
            Value : ImageUrl
        },
        {
            $Type : 'UI.DataField',
            Label : 'ProductName',
            Value : ProductName
        },
        {
            $Type  : 'UI.DataFieldForAnnotation',
            Label  : 'Supplier',
            Target : 'Supplier/@Communication.Contact'
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : Description
        },
        {
            $Type : 'UI.DataField',
            Label : 'ReleaseDate',
            Value : ReleaseDate
        },
        {
            $Type : 'UI.DataField',
            Label : 'DiscontinuedDate',
            Value : DiscontinuedDate
        },
        {
            Label       : 'Stock Availability',
            Value       : StockAvailability,
            Criticality : StockAvailability
        },
        {
            $Type : 'UI.DataField',
            Label : 'Rating',
            Value : Rating
        },
        {
            $Type : 'UI.DataField',
            Label : 'Price',
            Value : Price
        }
    ]
);

annotate service.Products with {
    ImageUrl @(UI.IsImageURL : true)
};

/**
 * Annotations for Search Help
 */
annotate service.Products with {

    //Category
    ToCategory        @(Common : {
        Text      : {
            $value                 : Category,
            ![@UI.TextArrangement] : #TextOnly,
        },
        ValueList : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'VH_Categories',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ToCategory_ID,
                    ValueListProperty : 'Code'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ToCategory_ID,
                    ValueListProperty : 'Text'
                }
            ]
        },
    });

    //Currency
    ToCurrency        @(Common : {
        ValueListWithFixedValues : false,
        ValueList                : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'VH_Currencies',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ToCurrency_ID,
                    ValueListProperty : 'Code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Text'
                }
            ]
        },
    });

    //Stock
    StockAvailability @(Common : {
        ValueListWithFixedValues : true,
        ValueList                : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'StockAvailability',
            Parameters     : [{
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : StockAvailability,
                ValueListProperty : 'ID'
            }]
        },
    });
};

/**
 * Annotations for VH_Categories Entity
 */
annotate service.VH_Categories with {
    Code @(
        UI     : {Hidden : true},
        Common : {Text : {
            $value                 : Text,
            ![@UI.TextArrangement] : #TextOnly,
        }}
    );
    Text @(UI : {HiddenFilter : true});
};

/**
 * Annotations for VH_Currencies Entity
 */
annotate service.VH_Currencies with {
    Code @(UI : {HiddenFilter : true});
    Text @(UI : {HiddenFilter : true});
};

/**
 * Annotations for StockAvailability Entity
 */
annotate service.StockAvailability with {
    ID @(Common : {Text : {
        $value                 : Description,
        ![@UI.TextArrangement] : #TextOnly,
    }, })
};

/**
 * Annotations for VH_UnitOfMeasure Entity
 */
annotate service.VH_UnitOfMeasure with {
    Code @(UI : {HiddenFilter : true});
    Text @(UI : {HiddenFilter : true});
};

/**
 * Annotations for VH_DimensionUnits Entity
 */
annotate service.VH_DimensionUnits with {
    Code @(UI : {HiddenFilter : true});
    Text @(UI : {HiddenFilter : true});
};

/**
 * Annotations for Supplier Entity
 */
annotate service.Supplier with @(Communication : {Contact : {
    $Type : 'Communication.ContactType',
    fn    : Name,
    role  : 'Supplier',
    photo : 'sap-icon://supplier',
    email : [{
        type    : #work,
        address : Email
    }],
    tel   : [
        {
            type : #work,
            uri  : Phone
        },
        {
            type : #fax,
            uri  : Fax
        }
    ]
}, });
