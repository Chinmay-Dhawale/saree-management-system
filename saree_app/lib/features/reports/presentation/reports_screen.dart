import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories.dart';

class ReportsScreen extends ConsumerWidget {
 const ReportsScreen({super.key});
 @override Widget build(BuildContext context,WidgetRef ref){
   final p=ref.watch(productionRepoProvider).all();
   final total=p.fold<int>(0,(a,x)=>a+x.quantity), amount=p.fold<double>(0,(a,x)=>a+x.amount);
   return ListView(padding:const EdgeInsets.all(16),children:[
     Text('Reports',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.bold)),
     const SizedBox(height:12),
     Card(child:ListTile(title:const Text('Production summary'),subtitle:Text('All recorded production'),trailing:Text('$total sarees'))),
     Card(child:ListTile(title:const Text('Production value'),subtitle:const Text('Total amount'),trailing:Text('₹${amount.toStringAsFixed(0)}'))),
     const SizedBox(height:12),
     FilledButton.icon(onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('PDF export will be enabled after Firebase/report storage setup.'))),icon:const Icon(Icons.picture_as_pdf),label:const Text('Export PDF')),
     OutlinedButton.icon(onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Excel export will be enabled after Firebase/report storage setup.'))),icon:const Icon(Icons.table_chart),label:const Text('Export Excel')),
   ]);
 }
}
