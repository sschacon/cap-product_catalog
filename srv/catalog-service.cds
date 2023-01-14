using {product_catalog as Product} from '../db/schema';
using {com.training as Training} from '../db/training';

//service CatalogService {
//    entity Products       as projection on Product.materials.Products;
//    entity Suppliers      as projection on Product.sales.Suppliers;
//    entity UnitOfMeasures as projection on Product.materials.UnitOfMeasures;
//    entity Months         as projection on Product.sales.Months;
//    entity Currency       as projection on Product.materials.Currencies;
//    entity DimensionUnits as projection on Product.materials.DimensionUnits;
//    entity Category       as projection on Product.materials.Categories;
//    entity SalesData      as projection on Product.sales.SalesData;
//    entity Reviews        as projection on Product.materials.ProductReview;
//    entity Orders         as projection on Product.sales.Orders;
//    entity OrderItems     as projection on Product.sales.OrderItems;
//}

define service CatalogService {
    entity Products          as
        select from Product.reports.Products {
            ID,
            Name           as ProductName     @mandatory,
            Description                       @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price                             @mandatory,
            Height,
            Width,
            Depth,
            Quantity                          @(
                mandatory,
                assert.range : [
                    0.00,
                    20.00
                ]
            ),
            UnitOfMeasure  as ToUnitOfMeasure @mandatory,
            Currency       as ToCurrency      @mandatory,
            Category       as ToCategory      @mandatory,
            Category.Name  as Category        @readonly,
            DimensionUnits as ToDimensionUnit,
            SalesData,
            Supplier,
            Reviews,
            Rating,
            StockAvailability,
            ToStockAvailibility
        };

    @readonly
    entity Supplier          as
        select from Product.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };

    @readonly
    entity Reviews           as
        select from Product.materials.ProductReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            Product as ToProduct
        };

    @readonly
    entity SalesData         as
        select from Product.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency.ID               as CurrencyKey,
            DeliveryMonth.ID          as DeliveryMonthId,
            DeliveryMonth.Description as DeliveryMonth,
            Product                   as ToProduct
        };

    @readonly
    entity StockAvailability as
        select from Product.materials.StockAvailability {
            ID,
            Description,
            Product as ToProduct,
        };

    @readonly
    entity VH_Categories     as
        select from Product.materials.Categories {
            ID   as Code,
            Name as Text
        };

    @readonly
    entity VH_Currencies     as
        select from Product.materials.Currencies {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_UnitOfMeasure  as
        select from Product.materials.UnitOfMeasures {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_DimensionUnits as
        select
            ID          as Code,
            Description as Text
        from Product.materials.DimensionUnits;
}

define service Myservice {
    entity SuppliersProduct as
        select from Product.materials.Products[Name = 'Bread']{
            *,
            Name,
            Description,
            Supplier.Address
        }
        where
            Supplier.Address.PostalCode = 98074;

    entity SupliersToSales  as
        select
            Supplier.Email,
            Category.Name,
            SalesData.Currency.ID,
            SalesData.Currency.Description
        from Product.materials.Products;

    entity EntityInfix      as
        select Supplier[Name = 'Exotic Liquids'].Phone from Product.materials.Products
        where
            Products.Name = 'Bread';

    entity EntityJoin       as
        select Phone from Product.materials.Products
        left join Product.sales.Suppliers as supp
            on(
                supp.ID = Products.Supplier.ID
            )
            and supp.Name = 'Exotic Liquids'
        where
            Products.Name = 'Bread';
}

define service Reports {
    entity AverageRating as projection on Product.reports.AverageRating;

    entity EntityCasting as
        select
            cast(
                Price as      Integer
            )     as Price,
            Price as Price2 : Integer
        from Product.materials.Products;

    entity EntityExists  as
        select from Product.materials.Products {
            Name
        }
        where
            exists Supplier[Name = 'Exotic Liquids'];

}
