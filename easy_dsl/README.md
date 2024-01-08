# EasyDSL: Streamlining Flutter UI Development (WIP)

## Introduction

EasyDSL is a Dart package that enhances Flutter UI development by introducing the concept of Domain-Specific Language (DSL). Drawing inspiration from the simplicity of TailwindCSS, EasyDSL enables Flutter developers to use DSL strings to generate Flutter widgets, greatly simplifying the creation of complex user interfaces.

The project is currently under heavy development. Many Tailwind properties are yet to be adapted. Due to the differences between Flutter and the web, not all Tailwind classes will be supported. Additionally, some unique classes will be incorporated.

## Features

- Offers a development experience akin to Tailwind CSS
- Relies on code generation, ensuring zero runtime cost
- Continuous development to expand DSL features

## Usage

You must initially set the Widget's name as `Div`.

```dart
// div.dart
import 'package:flutter/material.dart';
import 'package:easy_dsl/easy_dsl.dart';

part 'div.easy.g.dart';

@EasyDSL()
class Div extends $Div {
  const Div({super.key, required super.className, required super.children})
      : super(option: const EasyOption.empty());
}
```

Next, include the following in your `build.yaml` file:

```yaml
targets:
  $default:
    builders:
      easy_dsl_gen|easy_gen:
        generate_for:
          - lib/**.dart
```

Finally, you can use the code in your project as illustrated below:

```dart
@override
Widget build(BuildContext context) {
  const className = "items-center bg-black";

  return const Div(
    className: className,
    children: [
      Div(
        className: "bg-red-500 pt-[10] px-[100] py-[20]",
        children: [
          Div(
            className: "p-10 bg-gray-400",
            children: [Text('This is'), Text('EasyDSL')],
          ),
          SizedBox(height: 20),
          Div(
            className: "flex items-center p-[10] bg-gray-500",
            children: [Text('Hello World')],
          ),
        ],
      ),
    ],
  );
}
```

**Note:** The value of `className` must be a string literal or a constant to be resolved at compile time.

## Contributing

Contributions to EasyDSL are highly encouraged! If you have suggestions or code contributions, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
