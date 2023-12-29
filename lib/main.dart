import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String childMessageContent = "여기는 부모 위젯 영역이야";

  // 자식들에게 함수를 전달하자
  void onCallbackPressed() {
    // 화면에 렌더링 할려면 -->
    setState(() {
      childMessageContent = "자식에게 이벤트 발생 했네";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(child: Center(child: Text(childMessageContent))),
              Expanded(flex: 1, child: ChildA(callback: onCallbackPressed)),
              Expanded(flex: 1, child: ChildB(callback: onCallbackPressed)),
              // 자식이 생성될 때 부모의 함수를 받음
              // 자식에게 이벤트 발생하면 부모에게 콜백
            ],
          ),
        ),
      ),
    );
  }
}

class ChildA extends StatelessWidget {
  // 상태와, 기능
  final VoidCallback callback;

  const ChildA({required this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: callback,
        child: Container(
          width: double.infinity,
          color: Colors.orange,
          child: const Center(child: Text("CHILD A")),
        ),
      ),
    );
  }
}

class ChildB extends StatelessWidget {

  final VoidCallback callback;

  const ChildB({required this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: callback,
        child: Container(
          width: double.infinity,
          color: Colors.red,
          child: const Center(child: Text("CHILD B")),
        ),
      ),
    );
  }
}
