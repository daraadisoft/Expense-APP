import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/add_expense/view/add_expense_view.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/navigation_service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          navigationRow(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          NavigationService.instance.push(const AddExpenseView());
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Visibility(
        visible: MediaQuery.of(context).size.width < AppSize.tabletSize,
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (v){
            setState(() {
              index = v;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.receipt_outlined),
                label: AppTranslateKey.records.tr()
            ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.pie_chart_outline),
                label: AppTranslateKey.charts.tr())
          ],
        ),
      ),
    );
  }

  Widget navigationRow(BuildContext context){
    return Visibility(
        visible: MediaQuery.of(context).size.width > AppSize.tabletSize,
        child: NavigationRail(
          selectedIndex: index,
          onDestinationSelected: (v){
            setState(() {
              index = v;
            });
          },
          destinations: [
            NavigationRailDestination(
              icon: const Icon(Icons.receipt_outlined),
              selectedIcon: const Icon(Icons.receipt),
              label: Text(AppTranslateKey.records.tr()),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.pie_chart_outline),
              selectedIcon: const Icon(Icons.pie_chart),
              label: Text(AppTranslateKey.charts.tr()),
            ),
          ],
        )
    );
  }
}