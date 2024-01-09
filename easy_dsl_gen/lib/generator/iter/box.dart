import 'attr.dart';
import '../code/code_gen.dart';

final spacePattern = RegExp(r'^space(-x|y)?-(\[\d+(?:\.\d+)\]|.+)$');
final gapPattern = RegExp(r'^gap(-x|y)?-(\[\d+(?:\.\d+)\]|.+)$');

class BoxIter extends AttrIter {
  String _box = "Column";
  final _set = <String>{};
  String _size = "MainAxisSize.max";
  String _align = "MainAxisAlignment.start";
  String _cross = "CrossAxisAlignment.start";

  String _stackAlign = "AlignmentDirectional.topStart";
  String _stackFit = "StackFit.loose";
  String _stackClip = "Clip.hardEdge";
  String? _stackDirection;

  String? _gapX, _gapY;

  @override
  void iter(String cls) {
    _set.add(cls);

    switch (cls) {
      case "row":
      case "flex":
        if (!_set.contains("flex-col")) _box = "Row";
        break;
      case "col":
      case "flex-col":
        _box = "Column";
        break;
      // MainAxisSize
      case "inline":
      case "inline-block":
        _size = "MainAxisSize.min";
        break;
      case "block":
        _size = "MainAxisSize.max";
        break;
      // MainAxisAlignment
      case "justify-center":
        _align = "MainAxisAlignment.center";
        break;
      case "justify-end":
        _align = "MainAxisAlignment.end";
        break;
      case "justify-between":
        _align = "MainAxisAlignment.spaceBetween";
        break;
      case "justify-around":
        _align = "MainAxisAlignment.spaceAround";
        break;
      case "justify-evenly":
        _align = "MainAxisAlignment.spaceEvenly";
        break;
      // CrossAxisAlignment
      case "items-start":
        _cross = "CrossAxisAlignment.start";
        break;
      case "items-end":
        _cross = "CrossAxisAlignment.end";
        break;
      case "items-center":
        _cross = "CrossAxisAlignment.center";
        break;
      case "items-stretch":
        _cross = "CrossAxisAlignment.stretch";
        break;
      case "items-baseline":
        _cross = "CrossAxisAlignment.baseline";
        break;

      // stack
      case "stack":
        _box = "Stack";
        break;
      // stack fit
      case "stack-expand":
        _stackFit = "StackFit.expand";
        break;
      case "stack-loose":
        _stackFit = "StackFit.loose";
        break;
      // stack text direction
      case "stack-ltr":
        _stackDirection = "TextDirection.ltr";
        break;
      case "stack-rtl":
        _stackDirection = "TextDirection.rtl";
        break;
      // stack clip
      case "stack-soft":
        _stackClip = "Clip.antiAlias";
        break;
      case "stack-hard":
        _stackClip = "Clip.hardEdge";
        break;
      case "stack-soft-save":
        _stackClip = "Clip.antiAliasWithSaveLayer";
        break;
      // stack align
      case "stack-top-start":
        _stackAlign = "AlignmentDirectional.topStart";
        break;
      case "stack-top-center":
        _stackAlign = "AlignmentDirectional.topCenter";
        break;
      case "stack-top-end":
        _stackAlign = "AlignmentDirectional.topEnd";
        break;
      case "stack-center-start":
        _stackAlign = "AlignmentDirectional.centerStart";
        break;
      case "stack-center":
        _stackAlign = "AlignmentDirectional.center";
        break;
      case "stack-center-end":
        _stackAlign = "AlignmentDirectional.centerEnd";
        break;
      case "stack-bottom-start":
        _stackAlign = "AlignmentDirectional.bottomStart";
        break;
      case "stack-bottom-center":
        _stackAlign = "AlignmentDirectional.bottomCenter";
        break;
      case "stack-bottom-end":
        _stackAlign = "AlignmentDirectional.bottomEnd";
        break;
      default:
        if (spacePattern.hasMatch(cls)) {
          final match = spacePattern.firstMatch(cls)!;
          final axis = match.group(1);
          final value = match.group(2);
          if (value == null) return;

          if (axis == "-x") {
            _gapX = parseValue(value);
          } else if (axis == "-y") {
            _gapY = parseValue(value);
          } else {
            _gapX = parseValue(value);
            _gapY = _gapX;
          }
        } else if (gapPattern.hasMatch(cls)) {
          final match = gapPattern.firstMatch(cls)!;
          final axis = match.group(1);
          final value = match.group(2);
          if (value == null) return;

          if (axis == "-x") {
            _gapX = parseValue(value);
          } else if (axis == "-y") {
            _gapY = parseValue(value);
          } else {
            _gapX = parseValue(value);
            _gapY = _gapX;
          }
        }
        break;
    }
  }

  @override
  String? generate() {
    if (_box == "Stack") {
      return (CodeConstrutor(_box)
            ..add("fit", _stackFit)
            ..add("clipBehavior", _stackClip)
            ..add("alignment", _stackAlign)
            ..add("textDirection", _stackDirection)
            ..add("children", "children"))
          .generate();
    }

    final flex = CodeConstrutor(_box)
      ..add("mainAxisSize", _size)
      ..add("mainAxisAlignment", _align)
      ..add("crossAxisAlignment", _cross);

    if (_gapX != null && _box == "Row") {
      flex.add("children", "joinSpacer(children, SizedBox(width: $_gapX))");
    } else if (_gapY != null && _box == "Column") {
      flex.add("children", "joinSpacer(children, SizedBox(height: $_gapY))");
    } else {
      flex.add("children", "children");
    }

    return flex.generate();
  }

  String? parseValue(String value) {
    if (value.startsWith("[") && value.endsWith("]")) {
      return value.substring(1, value.length - 1);
    }
    return "spacing('$value')";
  }
}
