import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _inputDir = ".";
  String _outputDir = "./output/";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.blue,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: 480,
        height: 320,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      var dir = await FilePicker.platform.getDirectoryPath(
                          dialogTitle: "选择文件夹", lockParentWindow: false);
                      if (dir == null) {
                        return;
                      }
                      print(dir);
                      _inputDir = dir!;
                    },
                    child: const Text('选择 xlsx 目录'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: TextField(
                      maxLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'default input dir',
                        label: Text('当前目录'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: () async {
                        var dir = await FilePicker.platform.getDirectoryPath(
                            dialogTitle: "选择文件夹", lockParentWindow: false);
                        if (dir == null) {
                          return;
                        }
                        print(dir);
                        _outputDir = dir!;
                      },
                      child: const Text('选择目标目录')),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: TextField(
                      maxLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'output dir',
                        label: Text('输出目录'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print('start transfer...');
                      },
                      child: const Text('开始转换'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
