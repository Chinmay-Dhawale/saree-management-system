import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState()=>_LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final email=TextEditingController(text:'admin@example.com');
  final password=TextEditingController(text:'admin123');
  bool obscure=true;
  @override Widget build(BuildContext context)=>Scaffold(
    body: Center(child: SingleChildScrollView(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth:420),
      child: Padding(padding: const EdgeInsets.all(24), child: Card(
        child: Padding(padding: const EdgeInsets.all(24), child: Column(children:[
          const Icon(Icons.checkroom, size:72),
          const SizedBox(height:12),
          Text('Saree Management',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.bold)),
          const SizedBox(height:8),
          const Text('Admin Login'),
          const SizedBox(height:28),
          TextField(controller:email,keyboardType:TextInputType.emailAddress,decoration:const InputDecoration(labelText:'Email',prefixIcon:Icon(Icons.email_outlined))),
          const SizedBox(height:14),
          TextField(controller:password,obscureText:obscure,decoration:InputDecoration(labelText:'Password',prefixIcon:const Icon(Icons.lock_outline),suffixIcon:IconButton(icon:Icon(Icons.visibility),onPressed:()=>setState(()=>obscure=!obscure)))),
          const SizedBox(height:22),
          SizedBox(width:double.infinity,child:FilledButton.icon(onPressed:()=>context.go('/dashboard'),icon:const Icon(Icons.login),label:const Padding(padding:EdgeInsets.all(12),child:Text('Login')))),
          const SizedBox(height:10),
          const Text('Demo mode. Connect Firebase Authentication before production use.',textAlign:TextAlign.center)
        ])),
      ),
    ))),
  );
}
