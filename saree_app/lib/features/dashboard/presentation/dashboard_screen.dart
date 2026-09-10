import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../data/repositories.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});
  @override Widget build(BuildContext context, WidgetRef ref) {
    final workers=ref.watch(workerRepoProvider).all();
    final production=ref.watch(productionRepoProvider).all();
    final today=DateTime.now();
    final todayTotal=production.where((p)=>p.date.year==today.year&&p.date.month==today.month&&p.date.day==today.day).fold<int>(0,(s,p)=>s+p.quantity);
    final todayAmount=production.where((p)=>p.date.year==today.year&&p.date.month==today.month&&p.date.day==today.day).fold<double>(0,(s,p)=>s+p.amount);
    return ListView(padding:const EdgeInsets.all(16),children:[
      Text('Good day, Admin',style:Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight:FontWeight.bold)),
      const SizedBox(height:6), const Text('Here is your business overview.'),
      const SizedBox(height:18),
      GridView.count(crossAxisCount:MediaQuery.sizeOf(context).width>700?4:2,shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),crossAxisSpacing:12,mainAxisSpacing:12,childAspectRatio:1.7,children:[
        StatCard(title:'Active Workers',value:'${workers.where((w)=>w.status=="Active").length}',icon:Icons.people),
        StatCard(title:"Today's Sarees",value:'$todayTotal',icon:Icons.factory),
        StatCard(title:"Today's Amount",value:'₹${todayAmount.toStringAsFixed(0)}',icon:Icons.currency_rupee),
        const StatCard(title:'Pending Salary',value:'₹0',icon:Icons.pending_actions),
      ]),
      const SizedBox(height:20),
      Card(child:Padding(padding:const EdgeInsets.all(18),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text('Production overview',style:Theme.of(context).textTheme.titleLarge),
        const SizedBox(height:20),
        SizedBox(height:220,child:BarChart(BarChartData(
          barGroups: List.generate(7,(i)=>BarChartGroupData(x:i,barRods:[BarChartRodData(toY:(i==6?todayTotal: (i+1)*3).toDouble(),width:18,borderRadius:BorderRadius.circular(4))])),
          titlesData:FlTitlesData(bottomTitles:AxisTitles(sideTitles:SideTitles(showTitles:true,getTitlesWidget:(v,m)=>Text(['M','T','W','T','F','S','S'][v.toInt()]))),leftTitles:const AxisTitles(sideTitles:SideTitles(showTitles:true,reservedSize:35)),topTitles:const AxisTitles(sideTitles:SideTitles(showTitles:false)),rightTitles:const AxisTitles(sideTitles:SideTitles(showTitles:false))
        ))) 
      ]))),
    ]);
  }
}
