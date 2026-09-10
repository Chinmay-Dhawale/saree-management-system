import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories.dart';
import 'package:intl/intl.dart';

class ProductionScreen extends ConsumerStatefulWidget { const ProductionScreen({super.key}); @override ConsumerState<ProductionScreen> createState()=>_ProductionState(); }
class _ProductionState extends ConsumerState<ProductionScreen> {
 Future<void> add() async {
   final workers=ref.read(workerRepoProvider).all(), sarees=ref.read(sareeRepoProvider).all();
   String? wid=workers.firstOrNull?.id, sid=sarees.firstOrNull?.id; final qty=TextEditingController(text:'1');
   final ok=await showDialog<bool>(context:context,builder:(_)=>StatefulBuilder(builder:(context,setD)=>AlertDialog(title:const Text('Add Production'),content:Column(mainAxisSize:MainAxisSize.min,children:[
     DropdownButtonFormField<String>(value:wid,items:workers.map((w)=>DropdownMenuItem(value:w.id,child:Text(w.name))).toList(),onChanged:(v)=>setD(()=>wid=v),decoration:const InputDecoration(labelText:'Worker')),
     DropdownButtonFormField<String>(value:sid,items:sarees.map((s)=>DropdownMenuItem(value:s.id,child:Text('${s.name} — ₹${s.rate.toStringAsFixed(0)}'))).toList(),onChanged:(v)=>setD(()=>sid=v),decoration:const InputDecoration(labelText:'Saree Type')),
     TextField(controller:qty,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Quantity')),
   ]),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Cancel')),FilledButton(onPressed:()=>Navigator.pop(context,true),child:const Text('Save'))])));
   final q=int.tryParse(qty.text);
   if(ok==true&&wid!=null&&sid!=null&&q!=null&&q>0){final s=sarees.firstWhere((x)=>x.id==sid);ref.read(productionRepoProvider).add(wid!,sid!,q,s.rate,DateTime.now());setState((){});}
 }
 @override Widget build(BuildContext context){final p=ref.watch(productionRepoProvider).all().reversed.toList();final ws=ref.watch(workerRepoProvider).all(), ss=ref.watch(sareeRepoProvider).all();return Scaffold(body:p.isEmpty?const Center(child:Text('No production yet')):ListView.builder(padding:const EdgeInsets.all(12),itemCount:p.length,itemBuilder:(_,i){final x=p[i], w=ws.where((e)=>e.id==x.workerId).firstOrNull, s=ss.where((e)=>e.id==x.sareeTypeId).firstOrNull;return Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.factory)),title:Text('${w?.name??'Worker'} • ${s?.name??'Saree'}'),subtitle:Text('${DateFormat('dd MMM yyyy').format(x.date)} • Qty ${x.quantity} × ₹${x.rate.toStringAsFixed(0)}'),trailing:Text('₹${x.amount.toStringAsFixed(0)}',style:const TextStyle(fontWeight:FontWeight.bold)));})),floatingActionButton:FloatingActionButton.extended(onPressed:add,icon:const Icon(Icons.add),label:const Text('Production'));}
}
