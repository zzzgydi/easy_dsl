import 'attr.dart';

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
        break;
    }
  }

  @override
  String? generate() {
    if (_box == "Stack") {
      return "$_box(\n"
          "  fit: $_stackFit,\n"
          "  clipBehavior: $_stackClip,\n"
          "  alignment: $_stackAlign,\n"
          "${_stackDirection == null ? "" : "  textDirection: $_stackDirection,\n"}"
          "  children: children,\n"
          ")";
    }

    return "$_box(\n"
        "  mainAxisSize: $_size,\n"
        "  mainAxisAlignment: $_align,\n"
        "  crossAxisAlignment: $_cross,\n"
        "  children: children,\n"
        ")";
  }
}
