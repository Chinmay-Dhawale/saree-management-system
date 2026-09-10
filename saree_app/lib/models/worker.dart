class Worker {
  final String id, name, phone, address, status, notes;
  final DateTime joinDate;
  const Worker({required this.id, required this.name, required this.phone, required this.address, required this.joinDate, this.status='Active', this.notes=''});

  Worker copyWith({String? name,String? phone,String? address,DateTime? joinDate,String? status,String? notes}) => Worker(id:id,name:name??this.name,phone:phone??this.phone,address:address??this.address,joinDate:joinDate??this.joinDate,status:status??this.status,notes:notes??this.notes);
}
