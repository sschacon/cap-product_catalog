using {product_catalog as Product} from '../db/schema';

service CatalogService {
    entity Products  as projection on Product.Products;
    entity Suppliers as projection on Product.Suppliers;
    entity Car       as projection on Product.Car;
}
