# Local Database
Local Database Module for interacting with data saved offline in device application.
## Architecture
### Overal
```  
local  
├── hive                                    // Database Hive (deprecated)
├── isar                                    // Database isar using on Mobile (Isar v3.0)
│   ├── models                              // Contains all models for database table
│   │   ├── category                
│   │   ....  
│   │   ├── isar_model.dart                 // The parent class of all IsarDataModel
│   │   └── models.dart                     // export file
│   ├── repository                          // Entity-based Repository APIs
│   │   ├── base_repository_impl.dart       // Implementation of `base_repository.dart` in Isar
│   │   ├── category_repository_impl.dart   // Implementation of `category_repository.dart` in Isar
│   │   ....  
│   │   └── repository.dart                 // export file
│   ├── isar.dart                           // export file
│   ├── isar_di.dart                        // Contains method to inject class to get_it
│   ├── isar_di_fake.dart                   // Fake class for compile in web version
│   ├── isar_service_impl.dart              // Implementation of `local_database.dart` - Generic APIs
│   └── isar_type_path.dart                 // Helper class, function for Isar Database
├── isarx                                   // Database isar using on Web (Isar v2.5)
│   ├── models                              // Contains all models for database table
│   │   ├── category                
│   │   ....  
│   │   ├── isar_model.dart                 // The parent class of all IsarXDataModel
│   │   └── models.dart                     // export file
│   ├── repository                          // Entity-based Repository APIs
│   │   ├── base_repository_impl.dart       // Implementation of `base_repository.dart` in IsarX
│   │   ├── category_repository_impl.dart   // Implementation of `category_repository.dart` in IsarX
│   │   ....  
│   │   └── repository.dart                 // export file
│   ├── isarx.dart                          // export file
│   ├── isarx_di.dart                       // Contains method to inject class to get_it
│   ├── isarx_service_impl.dart             // Implementation of `local_database.dart` - Generic APIs
│   └── isarx_type_path.dart                // Helper class, function for Isar Database
├── prefs                                   // SharedPreferences for saving key-value
├── repository                              // Entity-based Repository APIs
│   ├── base_repository.dart                // Interface define general method
│   ├── category_repository.dart            // Interface define additional method, inherit for `BaseRepository`
│   ....  
│   └── repository.dart                     // export file
├── local.dart                              // export file
└── local_database.dart                     // Interface define generic method - Generic APIs (deprecated)
```  

### Component

With an entity type in the application, several files correspond in the database layer/ local directory.
```  

entities
├── category
│   ├── category.dart                                   // Entity in application
local
├── isar
│   ├── models
│   │   ├── category
│   │   │	├── category.dart                             // Data Model in Isar, corresponds to entity Category
│   │   │	└── category.g.dart                           // Generated file
│	  ├── repository
│	  │   └── category_repository_impl.dart               // Implementation for interface declared, using Isar
│   ├── isar_service_impl.dart                          // Define Schema and init connection to database
├── repository
│   └── category_repository.dart                        // Interface declared for method correspond with Category
```  

## Entity-Model database table creation flow.

Example with an entity named `Category` :
1. From the entity `Category` that existed in `entities/category`, navigate to `local/isar/models` and create a new directory name `category`.
2. In this directory, create new file name `category.dart` with the following code below:
```dart
import 'package:isar/isar.dart';  
import 'package:flutter_base/common/entities/entities.dart';  
  
import '../models.dart';  
  
part 'category.g.dart';  
  
@collection  
class CategoryIsarModel extends IsarModel {  
  Id id; // Id type int for Isar Generator 
  String name;  // Sample an attribute in class
  
  CategoryIsarModel({  
    required this.id,  
    required this.name,  
  });  
  
  CategoryIsarModel.fromEntity(Category category)  
      : id = category.id,  
        name = category.name;
  
  @override  
  Category toEntity() => Category(  
        id: id,  
        name: name
      );  
}
```
3. In `local/isar/models/isar_model.dart`,  add the created `CategoryIsarModel.fromEntity` into the `Map<Type, ValueGetterWithInput<AggregateRoot, IsarModel>> _mapper`  to provide generation.
4. In `local/isar/isar_service_impl.dart`, add the `CategoryIsarModelSchema` in type `IsarTuple<CategoryIsarModel>` into the `Map<Type, IsarTuple> _typeToEnum`  to register Schema to Isar database.
5. Navigate to `local/repository`, create file name `category_repository.dart` and add code to create an interface as below:
```dart
import 'package:flutter_base/common/entities/entities.dart';  
import 'package:flutter_base/common/local/repositories/base_repository.dart';  
  
abstract class CategoryRepository extends BaseRepository<Category> {  
  Future<Category> getTreeCategory(id);  // Eg: specific method (optional)
}
```
6. In `local/isar/repositories`, create new file name `category_repository_impl.dart` with implementation code for interface `CategoryRepository`
```dart
import 'package:isar/isar.dart';  
import 'package:flutter_base/common/entities/entities.dart';  
  
import '../../repositories/repositories.dart';  
import '../isar_type_path.dart';  
import '../models/models.dart';  
import 'base_repository_impl.dart';  
  
class IsarCategoryRepositoryImpl extends IsarBaseRepositoryImpl<Category, CategoryIsarModel>  
 implements CategoryRepository {  
  @override  
  Future<Category> getTreeCategory(id) async {  
    final category = await get(id);  
  
    category.children = _getAllChildCategory(id);  
  
    return category;  
  }  
    
  List<Category> _getAllChildCategory(id) {  
    final parentId = id is Id ? id : fastHash(id);  
  
    final query = isarCollection.filter().parentIdEqualTo(parentId).build();  
  
    if (query.isEmptySync()) return [];  
  
    final categories = query.findAllSync().map((e) {  
      final category = e.toEntity();  
      category.children = _getAllChildCategory(category.id);  
      return category;  
    });  
  
    return categories.toList();  
  }  
}
```
7. When the implementation class has been created, open file `local/isar/isar_di.dart` and add the code below to static method `Future<void> init` to register dependency injection:
```dart
injector.registerSingleton<CategoryRepository>(IsarCategoryRepositoryImpl());
```
8. Hot restart application and now we can start working with the Entity-based repository APIs or the deprecated Generic APIs.

#### Note
In some cases, we can override the existing method in the interface `BaseRepository`, with no need for creating a new method.
