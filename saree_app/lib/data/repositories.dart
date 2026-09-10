import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/worker.dart';
import '../models/saree_type.dart';
import '../models/production.dart';
import 'demo_data.dart';
import 'package:uuid/uuid.dart';

class WorkerRepository {
  final List<Worker> items = [...demoWorkers];
  List<Worker> all() => List.unmodifiable(items);
  void save(Worker w) { items.removeWhere((x)=>x.id==w.id); items.add(w); }
  void delete(String id) => items.removeWhere((x)=>x.id==id);
}
class SareeRepository {
  final List<SareeType> items = [...demoSarees];
  List<SareeType> all() => List.unmodifiable(items);
  void save(SareeType s) { items.removeWhere((x)=>x.id==s.id); items.add(s); }
  void delete(String id) => items.removeWhere((x)=>x.id==id);
}
class ProductionRepository {
  final List<Production> items = [...demoProduction];
  List<Production> all() => List.unmodifiable(items);
  void add(String workerId,String sareeId,int qty,double rate,DateTime date) {
    items.add(Production(id:const Uuid().v4(),workerId:workerId,sareeTypeId:sareeId,quantity:qty,rate:rate,amount:qty*rate,date:date));
  }
}
final workerRepoProvider = Provider((_) => WorkerRepository());
final sareeRepoProvider = Provider((_) => SareeRepository());
final productionRepoProvider = Provider((_) => ProductionRepository());
