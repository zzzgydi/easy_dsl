// part of 'div.dart';

// class Div$1 extends StatelessWidget {
//   const Div$1({super.key, this.children});

//   final List<Widget>? children;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: children!,
//     );
//   }
// }

// final map = <String, Type>{
//   "flex": Div$1,
// };

// Widget createWidget(String key, List<Widget> children) {
//   // 获取Widget类型
//   Type? type = map[key];

//   // 基于类型动态创建Widget实例
//   if (type == Div$1) return Div$1(children: children);

//   // 如果找不到匹配项，返回默认Widget
//   return Column(children: children);
// }
