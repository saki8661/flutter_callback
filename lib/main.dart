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
  // 매개 변수를 받을 수 있도록 설계하자
  // 함수의 설계 모양이 변경 됨
  // (msg){}, --> String
  // (context) {} --> BuildContext
  void onCallbackPressed(String msg) {
    // 화면에 렌더링 할려면 -->
    // setState --> build() 함수를 다시 실행해!!!
    setState(() {
      childMessageContent = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("부모 위젯에 빌드 함수가 다시 호출 되니?");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(child: Center(child: Text(childMessageContent))),
              Expanded(flex: 1, child: ChildA(onCallback: onCallbackPressed)),
              Expanded(flex: 1, child: ChildB(onCallback: onCallbackPressed)),
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
  // final VoidCallback callback; // (String msg) {}
  // Function() x
  final Function(String msg) onCallback;

  const ChildA({required this.onCallback, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        // () {}, 타입이 다르다
        onTap: (){
          onCallback("안녕 여기는 A");
        },
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

  final Function(String msg) onCallback;
  const ChildB({required this.onCallback, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: (){
          onCallback("하이 여기는 어딜까?");
        },
        child: Container(
          width: double.infinity,
          color: Colors.red,
          child: const Center(child: Text("CHILD B")),
        ),
      ),
    );
  }
}
