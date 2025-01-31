import 'package:tikka/adapters/abstract_repository.dart';
import 'package:tikka/util/rest_response.dart';
import 'package:tikka_demo_app/adapter/data_source_interface/products_data_source.dart';
import 'package:tikka_demo_app/adapter/repository/json_to_product_converter.dart';
import 'package:tikka_demo_app/domain/entity/product.dart';
import 'package:tikka_demo_app/domain/repository_interface/products_repository.dart';

class ProductsRepositoryImpl extends AbstractRepository implements ProductsRepository {
  
  @override
  Future<RestResponse> getProducts() async {
    final ProductsDataSource dataSource = get<ProductsDataSource>();
    final response = await dataSource.getProducts();

    try {
      if (response is Success) {
        final map = (response as Success<Map<String, dynamic>>).data;
        List list = map["products"];
        List<Product> products = List.generate(list.length, (i) => JsonToProductConverter().asProduct(list[i]));
        return Success(products);
      } else {
        return response as Failure;
      }
    } catch (e) {
      return Failure("Failed to fetch products. Error: $e");
    }
  }
}