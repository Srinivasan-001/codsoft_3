import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/theme/them_provider.dart';
import 'package:provider/provider.dart';
class SettingsPages extends StatelessWidget {
  const SettingsPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text("S E T T IN G S"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        margin:  const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          //dark mode
          const Text("Dark Mode",style: TextStyle(fontWeight: FontWeight.bold),),
          //switch
          CupertinoSwitch(
            value: Provider.of<ThemProvider>(context,listen: false).isDarkMode, 
          onChanged: (value) =>Provider.of<ThemProvider>(context,listen: false).toggleTheme(),
          ),
        ],
        ),
      ),
    );
  }
}