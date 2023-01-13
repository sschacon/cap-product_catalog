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
        select from Product.materials.Products {
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
            Quantity                          @mandatory @assert.range,
            UnitOfMeasure  as ToUnitOfMeasure @mandatory,
            Currency       as ToCurrency      @mandatory,
            Category       as ToCategory      @mandatory,
            Category.Name  as Category        @readonly,
            DimensionUnits as ToDimensionUnit,
            SalesData,
            Supplier,
            Reviews
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
        select from Product.materials.DimensionUnits {
            ID          as Code,
            Description as Text
        };
}
