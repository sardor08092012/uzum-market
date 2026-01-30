import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uzum_market/src/features/home/model/product_model.dart';

class HiveService {
  static String boxName = "cars";
  static var carBox = Hive.box<ProductModel>(boxName);

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    print(directory.path);
    Hive.registerAdapter(ProductModelAdapter()); // * hive modelini tanitish
    carBox = await Hive.openBox(boxName);
  }

  Future<void> writeData(ProductModel car) async {
    carBox = await Hive.openBox(boxName);
    carBox.add(car);
    print('MALUMOTLAR');
    print(await getCars());
  }

  Future<List<ProductModel>> getCars() async {
    carBox = await Hive.openBox(boxName);
    return carBox.values.toList();
  }
}