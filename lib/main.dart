import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Blood Sugar Monitor',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/input',
      getPages: [
        GetPage(name: '/input', page: () => InputScreen()),
        GetPage(name: '/info', page: () => InfoScreen()),
      ],
    );
  }
}

class InputScreen extends StatelessWidget {
  final TextEditingController beforeController = TextEditingController();
  final TextEditingController afterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Input Blood Sugar Data'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: beforeController,
              decoration: const InputDecoration(
                labelText: 'Before Meal',

                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),

            TextField(
              controller: afterController,
              decoration: const InputDecoration(
                labelText: 'After Meal',

                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(
                  fontSize: 18,

                ),
              ),
              onPressed: () {
                double before = double.tryParse(beforeController.text) ?? 0;
                double after = double.tryParse(afterController.text) ?? 0;
                if (before > 0 && after > 0) {
                  Get.toNamed('/info', arguments: {'before': before, 'after': after});
                } else {
                  Get.defaultDialog(
                    title: 'Invalid Data',
                    cancelTextColor: Colors.green,

                    middleText: 'Please enter valid blood sugar readings.',
                  );
                }
              },
              child: const Text('Show Info'),

            ),
          ],
        ),
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    double before = arguments['before'];
    double after = arguments['after'];
    String category = getCategory(before, after);


    return Scaffold(
      backgroundColor: Colors.greenAccent,

      appBar: AppBar(
        title: const Text('Blood Sugar Category Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Before Meal: $before mg/dL',
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            Text(
              'After Meal: $after mg/dL',
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            Text(
              'Category: $category',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

            ),
          ],
        ),
      ),
    );
  }

  String getCategory(double before, double after) {
    if (before >= 80 && before <= 130 && after < 180) {
      return 'Normal';

    } else if ((before >= 80 && before <= 130) &&
        (after >= 90 && after <= 150)) {
      return 'Normal';
    } else {
      return 'Abnormal';

    }
  }
}
