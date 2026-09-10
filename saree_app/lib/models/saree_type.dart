class SareeType {
  final String id, name, description, status;
  final double rate;
  final DateTime createdDate;
  const SareeType({required this.id,required this.name,required this.rate,required this.description,required this.createdDate,this.status='Active'});
}
