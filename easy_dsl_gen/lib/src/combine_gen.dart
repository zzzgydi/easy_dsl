import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class CombineGenerator extends Generator {
  @override
  Future<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final StringBuffer output = StringBuffer();

    final uri = library.element.source.uri;
    final code = library.element.source.contents.data;

    print("=============== CombineGenerator ===============");
    print("[uri]: $uri");
    print("[code]:\n$code");
  }
}
