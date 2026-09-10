import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories.dart';
import '../../../models/worker.dart';

class WorkersScreen extends ConsumerStatefulWidget { const WorkersScreen({super.key}); @override ConsumerState<WorkersScreen> createState()=>_WorkersScreenState(); }
class _WorkersScreenState extends ConsumerState<WorkersScreen> {
  String q='';
  Future<void> addOrEdit([Worker? existing]) async {
    final name=TextEditingController(text:existing?.name??'');
    final phone=TextEditingController(text:existing?.phone??'');
    final address=TextEditingController(text:existing?.address??'');
    final result=await showDialog<bool>(context:context,builder:(_)=>AlertDialog(
      title:Text(existing==null?'Add Worker':'Edit Worker'),
      content:SingleChildScrollView(child:Column(children:[
        TextField(controller:name,decoration:const InputDecoration(labelText:'Name')),
        TextField(controller:phone,keyboardType:TextInputType.phone,decoration:const InputDecoration(labelText:'Phone')),
        TextField(controller:address,decoration:const InputDecoration(labelText:'Address')),
      ])),
      actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Cancel')),FilledButton(onPressed:()=>Navigator.pop(context,true),child:const Text('Save'))],
    ));
    if(result==true && name.text.trim().isNotEmpty) {
      final repo=ref.read(workerRepoProvider);
      repo.save(Worker(id:existing?.id??DateTime.now().microsecondsSinceEpoch.toString(),name:name.text.trim(),phone:phone.text.trim(),address:address.text.trim(),joinDate:existing?.joinDate??DateTime.now(),status:existing?.status??'Active'));
      setState(());
    }
  }
  @override Widget build(BuildContext context) {
    final items=ref.watch(workerRepoProvider).all().where((w)=>w.name.toLowerCase().contains(q.toLowerCase())||w.phone.contains(q)).toList();
    return Scaffold(body:Column(children:[
      Padding(padding:const EdgeInsets.all(16),child:TextField(onChanged:(v)=>setState(()=>q=v),decoration:const InputDecoration(prefixIcon:Icon(Icons.search),labelText:'Search workers',border:OutlineInputBorder()))),
      Expanded(child:items.isEmpty?const Center(child:Text('No workers found')):ListView.builder(itemCount:items.length,itemBuilder:(_,i){final w=items[i];return ListTile(leading:CircleAvatar(child:Text(w.name[0])),title:Text(w.name),subtitle:Text('${w.phone} • ${w.status}'),trailing:PopupMenuButton(itemBuilder:(_)=>[const PopupMenuItem(value:'edit',child:Text('Edit')),const PopupMenuItem(value:'delete',child:Text('Delete'))],onSelected:(v){if(v=='edit')addOrEdit(w);else {ref.read(workerRepoProvider).delete(w.id);setState((){});}}));})),
    ]),floatingActionButton:FloatingActionButton.extended(onPressed:()=>addOrEdit(),icon:const Icon(Icons.person_add),label:const Text('Worker')));
  }
}
