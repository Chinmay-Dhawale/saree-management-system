import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories.dart';

class SalaryScreen extends ConsumerWidget {
 const SalaryScreen({super.key});
 @override Widget build(BuildContext context,WidgetRef ref){
   final ws=ref.watch(workerRepoProvider).all(), p=ref.watch(productionRepoProvider).all();
   return ListView(padding:const EdgeInsets.all(12),children:[
     Text('Weekly Salary',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.bold)),
     const SizedBox(height:6),const Text('Calculated from saved production records.'),
     const SizedBox(height:12),
     ...ws.map((w){final rows=p.where((x)=>x.workerId==w.id);final amount=rows.fold<double>(0,(a,x)=>a+x.amount);final qty=rows.fold<int>(0,(a,x)=>a+x.quantity);return Card(child:ListTile(leading:CircleAvatar(child:Text(w.name[0])),title:Text(w.name),subtitle:Text('$qty sarees • Pending'),trailing:Text('₹${amount.toStringAsFixed(0)}',style:const TextStyle(fontWeight:FontWeight.bold,fontSize:17))));}),
   ]);
 }
}
