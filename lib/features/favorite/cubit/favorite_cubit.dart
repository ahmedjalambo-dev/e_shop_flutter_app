import 'package:e_shop_flutter_app/features/favorite/cubit/favorite_state.dart';
import 'package:e_shop_flutter_app/features/favorite/data/repos/favorite_repo.dart';
import 'package:e_shop_flutter_app/features/home/data/models/products_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepo _favoriteRepo;

  FavoriteCubit(this._favoriteRepo) : super(const FavoriteState.initial()) {
    // Load favorites as soon as the cubit is created
    loadFavorites();
  }

  /// Load all favorites from the database.
  Future<void> loadFavorites() async {
    try {
      emit(const FavoriteState.loading());
      final favorites = await _favoriteRepo.getFavorites();
      final Set<String> ids = favorites.map((f) => f.id).toSet();
      emit(FavoriteState.loaded(favorites, ids));
    } catch (e) {
      emit(FavoriteState.error(e.toString()));
    }
  }

  /// Toggles the favorite state of a product.
  Future<void> toggleFavorite(Product product) async {
    // Get the current state
    final currentState = state;
    if (currentState is! Loaded) return; // Only work if state is loaded

    final currentIds = currentState.favoriteProductIds;
    final currentList = currentState.favorites;

    try {
      if (currentIds.contains(product.id)) {
        // --- Remove from Favorites ---
        await _favoriteRepo.removeFromFavorites(product.id);
        // Create new state by removing the item
        final newList = currentList.where((p) => p.id != product.id).toList();
        final newIds = Set<String>.from(currentIds)..remove(product.id);
        emit(FavoriteState.loaded(newList, newIds));
      } else {
        // --- Add to Favorites ---
        await _favoriteRepo.addToFavorites(product);
        // Create new state by adding the item
        final newList = List<Product>.from(currentList)..add(product);
        final newIds = Set<String>.from(currentIds)..add(product.id);
        emit(FavoriteState.loaded(newList, newIds));
      }
    } catch (e) {
      emit(FavoriteState.error(e.toString()));
      // On error, reload the "source of truth" from the DB
      await loadFavorites();
    }
  }

  /// Helper function for instant favorite check in the UI.
  bool isFavorite(String productId) {
    if (state is Loaded) {
      return (state as Loaded).favoriteProductIds.contains(productId);
    }
    return false;
  }
}
