import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
 final VoidCallback onToggleTheme;
 const SettingsScreen({super.key,required this.onToggleTheme});
 @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(12),children:[
   const ListTile(title:Text('Settings'),subtitle:Text('Manage your business app')),
   SwitchListTile(value:Theme.of(context).brightness==Brightness.dark,onChanged:(_)=>onToggleTheme(),title:const Text('Dark mode'),secondary:const Icon(Icons.dark_mode)),
   const ListTile(leading:Icon(Icons.business),title:Text('Company'),subtitle:Text('Saree Manufacturing Business')),
   ListTile(leading:const Icon(Icons.backup),title:const Text('Backup & Restore'),subtitle:const Text('Cloud backup through Firebase')),
   ListTile(leading:const Icon(Icons.security),title:const Text('Security'),subtitle:const Text('Admin-only access')),
   ListTile(leading:const Icon(Icons.logout),title:const Text('Logout'),onTap:()=>context.go('/login')),
 ]);
}
