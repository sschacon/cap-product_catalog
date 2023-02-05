using CatalogService as service from '../../srv/catalog-service';

annotate service.Products with @(

    //CAPABILITIES
    Capabilities                   : {DeleteRestrictions : {
        $Type     : 'Capabilities.DeleteRestrictionsType',
        Deletable : false
    }, },

    //HEADERINFO
    UI.HeaderInfo                  : {
        TypeName       : '{i18n>Product}',
        TypeNamePlural : '{i18n>Products}',
        ImageUrl       : ImageUrl,
        Title          : {Value : ProductName},
        Description    : {Value : Description}
    },

    //SELECTIONFIELDS
    UI.SelectionFields             : [
        CategoryID,
        CurrencyID,
        StockAvailability
    ],

    //LINEITEM
    UI.LineItem                    : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>ImageUrl}',
            Value : ImageUrl
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>ProductName}',
            Value : ProductName
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Description}',
            Value : Description
        },
        {
            $Type  : 'UI.DataFieldForAnnotation',
            Label  : '{i18n>Supplier}',
            Target : 'Supplier/@Communication.Contact'
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>ReleaseDate}',
            Value : ReleaseDate
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>DiscontinuedDate}',
            Value : DiscontinuedDate
        },
        {
            Label       : '{i18n>StockAvailability}',
            Value       : StockAvailability,
            Criticality : StockAvailability
        },
        {
            //$Type : 'UI.DataField',
            Label  : '{i18n>Rating}',
            //Value : Rating
            $Type  : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#AverageRating'
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Price}',
            Value : Price
        }
    ],

    //FIELDGROUP
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>ReleaseDate}',
                Value : ReleaseDate
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>DiscontinuedDate}',
                Value : DiscontinuedDate
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Price}',
                Value : Price
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Height}',
                Value : Height
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Width}',
                Value : Width
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Depth}',
                Value : Depth
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Quantity}',
                Value : Quantity
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>ToUnitOfMeasure_ID}',
                Value : ToUnitOfMeasure_ID
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>CurrencyId}',
                Value : ToCurrency_ID
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>CategoryId}',
                Value : ToCategory_ID
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Category}',
                Value : Category
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>ToDimensionUnit_ID}',
                Value : ToDimensionUnit_ID
            },
            // {
            //     //$Type : 'UI.DataField',
            //     Label  : 'Rating',
            //     //Value : Rating
            //     $Type  : 'UI.DataFieldForAnnotation',
            //     Target : '@UI.DataPoint#AverageRating'
            // },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>StockAvailability}',
                Value : StockAvailability
            }
        ]
    },

    //FACETS
    UI.Facets                      : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'GeneratedFacet1',
            Label  : '{i18n>GeneralInformation}',
            Target : '@UI.FieldGroup#GeneratedGroup1'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'GeneratedFacet2',
            Label  : '{i18n>GeneralInformationCopy}',
            Target : '@UI.FieldGroup#GeneratedGroup1'
        },
    ],

    //HEADERFACETS
    UI.HeaderFacets                : [{
        $Type  : 'UI.ReferenceFacet',
        Target : '@UI.DataPoint#AverageRating'
    }]

);

annotate service.Products with {
    ImageUrl @(UI.IsImageURL : true)
};

annotate service.Products with {
    CategoryID        @title : '{i18n>CategoryId}';
    CurrencyID        @title : '{i18n>CurrencyId}';
    StockAvailability @title : '{i18n>StockAvailability}'
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
    Text @(UI : {
        title        : '{i18n>Text}',
        HiddenFilter : true
    });
};

/**
 * Annotations for VH_Currencies Entity
 */
annotate service.VH_Currencies with {
    Code @(UI : {
        title        : '{i18n>Code}',
        HiddenFilter : true
    });
    Text @(UI : {
        title        : '{i18n>Text}',
        HiddenFilter : true
    });
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
    Code @(UI : {
        title        : '{i18n>Code}',
        HiddenFilter : true
    });
    Text @(UI : {
        title        : '{i18n>Text}',
        HiddenFilter : true
    });
};

/**
 * Annotations for VH_DimensionUnits Entity
 */
annotate service.VH_DimensionUnits with {
    Code @(UI : {
        title        : '{i18n>Code}',
        HiddenFilter : true
    });
    Text @(UI : {
        title        : '{i18n>Text}',
        HiddenFilter : true
    });
};

/**
 * Annotations for Supplier Entity
 */
annotate service.Supplier with @(Communication : {Contact : {
    $Type : 'Communication.ContactType',
    fn    : Name,
    role  : '{i18n>Supplier}',
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

/**
 * Data Point for Average Rating
 */
annotate service.Products with @(UI.DataPoint #AverageRating : {
    Value         : Rating,
    Title         : '{i18n>Rating}',
    TargetValue   : 5,
    Visualization : #Rating
});
