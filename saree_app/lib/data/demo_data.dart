import '../models/worker.dart';
import '../models/saree_type.dart';
import '../models/production.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

final demoWorkers = <Worker>[
  Worker(id:'w1',name:'Lakshmi',phone:'9876543210',address:'Bengaluru',joinDate:DateTime(2026,1,10)),
  Worker(id:'w2',name:'Ravi',phone:'9876501234',address:'Bengaluru',joinDate:DateTime(2026,2,5)),
];

final demoSarees = <SareeType>[
  SareeType(id:'s1',name:'Silk Border',rate:250,description:'Traditional silk border saree',createdDate:DateTime(2026,1,1)),
  SareeType(id:'s2',name:'Designer',rate:450,description:'Designer saree',createdDate:DateTime(2026,1,1)),
  SareeType(id:'s3',name:'Wedding',rate:700,description:'Wedding collection',createdDate:DateTime(2026,1,1)),
];

final demoProduction = <Production>[
  Production(id:_uuid.v4(),workerId:'w1',sareeTypeId:'s1',quantity:12,rate:250,amount:3000,date:DateTime.now()),
  Production(id:_uuid.v4(),workerId:'w1',sareeTypeId:'s2',quantity:5,rate:450,amount:2250,date:DateTime.now()),
  Production(id:_uuid.v4(),workerId:'w2',sareeTypeId:'s3',quantity:2,rate:700,amount:1400,date:DateTime.now()),
];
