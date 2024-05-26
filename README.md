# silangka

A new Flutter project.

## Development

- **Mode Development** (default):

  ```sh
  flutter run
  ```

- **Mode Production**:

  ```sh
  flutter run --release
  ```

## Build APK

- **Mode Production**:

  ```sh
  flutter build apk --release
  ```


### Penjelasan

- **`_devBaseUrl` dan `_prodBaseUrl`**: URL untuk mode development dan produksi.
- **`baseUrl` getter**: Mengembalikan URL yang sesuai berdasarkan mode aplikasi.
- **`bool.fromEnvironment('dart.vm.product')`**: Menggunakan variabel lingkungan untuk menentukan apakah aplikasi sedang berjalan dalam mode produksi (`true`) atau tidak (`false`).