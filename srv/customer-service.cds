using {product_catalog as Product} from '../db/schema';

service CustomerService {
    entity CustomerSrv as projection on Product.Customer;
}
