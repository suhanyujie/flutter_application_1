import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Convert2Json extends StatefulWidget {
  const Convert2Json({super.key});

  @override
  State<Convert2Json> createState() => _Convert2JsonState();
}

class _Convert2JsonState extends State<Convert2Json> {
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '转换 xlsx 文件为 json',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('转换为 json'),
        ),
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 100,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        print('btn clicked...');
                      },
                      child: const Text('选择目录'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('确认'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openFilePicker() async {
    String? result =
        await FilePicker.platform.getDirectoryPath(dialogTitle: "选择目录");
    if (result != null) {
      setState(() {
        filePath = result!;
      });
    }
  }
}
