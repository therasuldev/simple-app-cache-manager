/// A contract defining methods to interact with application cache.
///
/// This interface provides methods for managing the application cache.
/// Implementations of this interface should handle checking cache existence,
/// calculating the total cache size, and clearing the cache.
abstract class ISimpleAppCacheManager {
  /// Checks if the cache path exists.
  ///
  /// Returns `true` if the cache path exists, otherwise `false`.
  ///
  /// Returns `null` if the cache existence check encounters an error.
  Future<bool> get checkCacheExistence;

  /// Returns the total cache size as a human-readable string.
  ///
  /// This method calculates the total size of the cache and formats it
  /// into a human-readable format (e.g., "2.34 MB").
  ///
  /// Returns `null` if the cache size calculation encounters an error.
  Future<String> getTotalCacheSize();

  /// Clears all accumulated cache.
  ///
  /// This method deletes all files and data within the cache, effectively
  /// resetting it.
  void clearCache();
}