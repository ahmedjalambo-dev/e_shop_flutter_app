import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/home/cubit/products_state.dart';
import 'package:e_shop_flutter_app/features/home/data/models/products_request_body.dart';
import 'package:e_shop_flutter_app/features/home/data/repos/products_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo _productsRepo;
  ProductsCubit(this._productsRepo) : super(const ProductsState.initial());

  Future<void> emitProductsStates() async {
    emit(const ProductsState.loading());
    final response = await _productsRepo.getProdcuts(
      ProductsRequestBody(pageSize: 10),
    );
    response.when(
      success: (productsResponse) =>
          emit(ProductsState.success(productsResponse)),
      failure: (errorHandler) => emit(
        ProductsState.failure(
          errorHandler.apiErrorModel.message ?? 'An error occurred',
        ),
      ),
    );
  }
}
