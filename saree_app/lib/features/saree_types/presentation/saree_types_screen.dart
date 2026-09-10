import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories.dart';
import '../../../models/saree_type.dart';

class SareeTypesScreen extends ConsumerStatefulWidget { const SareeTypesScreen({super.key}); @override ConsumerState<SareeTypesScreen> createState()=>_SareeTypesState(); }
class _SareeTypesState extends ConsumerState<SareeTypesScreen> {
 Future<void> add([SareeType? old]) async {
   final n=TextEditingController(text:old?.name??''), r=TextEditingController(text:old==null?'':old.rate.toString()), d=TextEditingController(text:old?.description??'');
   final ok=await showDialog<bool>(context:context,builder:(_)=>AlertDialog(title:Text(old==null?'Add Saree Type':'Edit Saree Type'),content:Column(mainAxisSize:MainAxisSize.min,children:[TextField(controller:n,decoration:const InputDecoration(labelText:'Name')),TextField(controller:r,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Rate (₹)')),TextField(controller:d,decoration:const InputDecoration(labelText:'Description'))]),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Cancel')),FilledButton(onPressed:()=>Navigator.pop(context,true),child:const Text('Save'))]));
   final rate=double.tryParse(r.text);
   if(ok==true&&n.text.trim().isNotEmpty&&rate!=null){ref.read(sareeRepoProvider).save(SareeType(id:old?.id??DateTime.now().microsecondsSinceEpoch.toString(),name:n.text.trim(),rate:rate,description:d.text.trim(),createdDate:old?.createdDate??DateTime.now(),status:old?.status??'Active'));setState((){});}
 }
 @override Widget build(BuildContext context){final items=ref.watch(sareeRepoProvider).all();return Scaffold(body:ListView.builder(padding:const EdgeInsets.all(12),itemCount:items.length,itemBuilder:(_,i){final s=items[i];return Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.checkroom)),title:Text(s.name),subtitle:Text(s.description),trailing:Row(mainAxisSize:MainAxisSize.min,children:[Text('₹${s.rate.toStringAsFixed(0)}',style:const TextStyle(fontWeight:FontWeight.bold)),IconButton(onPressed:()=>add(s),icon:const Icon(Icons.edit))]));})),floatingActionButton:FloatingActionButton.extended(onPressed:()=>add(),icon:const Icon(Icons.add),label:const Text('Saree Type'));}
}
