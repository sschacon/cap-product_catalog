using {product_catalog as Product} from '../db/schema';

service CatalogService {
    entity Products       as projection on Product.Products;
    entity Suppliers      as projection on Product.Suppliers;
    entity Car            as projection on Product.Car;
    entity UnitOfMeasures as projection on Product.UnitOfMeasures;
    entity Months         as projection on Product.Months;
    entity Currency       as projection on Product.Currencies;
    entity DimensionUnits as projection on Product.DimensionUnits;
    entity Category       as projection on Product.Categories;
    entity SalesData      as projection on Product.SalesData;
    entity Reviews        as projection on Product.ProductReview;
    entity Orders         as projection on Product.Orders;
    entity OrderItems     as projection on Product.OrderItems;
}
