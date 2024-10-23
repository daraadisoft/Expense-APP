import 'package:expense_app/features/add_expense/view/add_expense_view.dart';
import 'package:expense_app/features/record/controller/record_controller.dart';
import 'package:expense_app/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordView extends StatefulWidget {
  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  RecordController recordController = RecordController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        recordController.init();
        return recordController;
      },
      child: Consumer<RecordController>(
        builder: (context, controller, child) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async{
               var map = await NavigationService.instance.push(const AddExpenseView());
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
