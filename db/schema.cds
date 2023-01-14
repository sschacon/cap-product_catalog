namespace product_catalog;

using {
    cuid,
    managed
} from '@sap/cds/common';

define type Name : String(50);

type address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
};

context materials {
    entity Products : cuid, managed {
        Name             : localized String not null;
        Description      : localized String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        CreationDate     : Date default CURRENT_DATE;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        Height           : type of Price; //Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        Supplier         : Association to sales.Suppliers;
        UnitOfMeasure    : Association to UnitOfMeasures;
        Currency         : Association to Currencies;
        DimensionUnits   : Association to DimensionUnits;
        Category         : Association to Categories;
        SalesData        : Association to many sales.SalesData
                               on SalesData.Product = $self;
        Reviews          : Association to many ProductReview
                               on Reviews.Product = $self;
    };

    entity Categories {
        key ID   : String(1);
            Name : localized String;
    };

    entity StockAvailability {
        key ID          : Integer;
            Description : localized String;
            Product     : Association to materials.Products;
    };

    entity UnitOfMeasures {
        key ID          : String(2);
            Description : localized String;
    };

    entity DimensionUnits {
        key ID          : String(2);
            Description : localized String;
    };

    entity Currencies {
        key ID          : String(3);
            Description : localized String;
    };

    entity ProductReview : cuid, managed {
        Name    : String;
        Rating  : Integer;
        Comment : String;
        Product : Association to materials.Products;
    };

    entity SelProducts   as select from materials.Products;

    entity SelProducts1  as
        select from materials.Products {
            *
        };

    entity SelProducts2  as
        select from materials.Products {
            Name,
            Price,
            Quantity
        };

    entity SelProducts3  as
        select from materials.Products
        left join materials.ProductReview
            on Products.Name = ProductReview.Name
        {
            Rating,
            Products.Name,
            sum(Price) as TotalPrice
        }
        group by
            Rating,
            Products.Name
        order by
            Rating;


    entity ProjProducts  as projection on materials.Products;

    entity ProjProducts2 as projection on materials.Products {
        *
    }

    entity ProjProducts3 as projection on materials.Products {
        ReleaseDate,
        Name
    }

}

context sales {

    entity Orders : cuid {
        Date     : Date;
        Customer : String;
        Item     : Composition of many OrderItems
                       on Item.Order = $self;
    };

    entity OrderItems : cuid {
        Order    : Association to Orders;
        Product  : Association to materials.Products;
        Quantity : Integer;
    };

    entity Suppliers : cuid, managed {
        Name    : type of materials.Products : Name;
        Address : address;
        Email   : String;
        Phone   : String;
        Fax     : String;
        Product : Association to many materials.Products
                      on Product.Supplier = $self;
    };

    entity SalesData : cuid, managed {
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to materials.Products;
        Currency      : Association to materials.Currencies;
        DeliveryMonth : Association to Months;
    };

    entity Months {
        key ID               : String(2);
            Description      : localized String;
            ShortDescription : localized String(3);
    };

}

context reports {
    entity AverageRating as
        select from materials.ProductReview {
            Product.ID  as ProductId,
            avg(Rating) as AverageRating : Decimal(16, 2)
        }
        group by
            Product.ID;

    entity Products      as
        select from materials.Products
        mixin {
            ToStockAvailibility : Association to materials.StockAvailability
                                      on ToStockAvailibility.ID = $projection.StockAvailability;
            ToAverageRating     : Association to AverageRating
                                      on ToAverageRating.ProductId = ID;
        }
        into {
            *,
            ToAverageRating.AverageRating as Rating,
            case
                when
                    Quantity >= 8
                then
                    3
                when
                    Quantity > 0
                then
                    2
                else
                    1
            end                           as StockAvailability : Integer,
            ToStockAvailibility
        }

}
