import 'package:animations_example/shared.dart';
import 'package:flutter/material.dart';

class ImplicitSwitcherPage extends StatefulWidget {
  @override
  _ImplicitSwitcherPageState createState() => _ImplicitSwitcherPageState();
}

class _ImplicitSwitcherPageState extends State<ImplicitSwitcherPage> {
  bool toggled = false;
  List<bool> options = [true, false, false];

  List<Widget> get optionButtons {
    return [
      Icon(Icons.open_in_full_rounded),
      Icon(Icons.rotate_90_degrees_ccw_rounded),
      Icon(Icons.remove_red_eye_rounded),
    ];
  }

  Widget get untoggledWidget {
    return Icon(Icons.ac_unit_rounded, size: 32.0);
  }

  Widget get toggledWidget {
    return Container(
      width: 100,
      height: 100,
      color: Colors.green,
    );
  }

  void handleOptionPressed(int index) {
    setState(() {
      options.forEach((o) {
        options[options.indexOf(o)] = false;
      });
      options[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bytting av widgets'),
        actions: [
          IconButton(
            icon: Icon(
              toggled ? Icons.toggle_on_rounded : Icons.toggle_off_rounded,
            ),
            onPressed: () => setState(() => toggled = !toggled),
          ),
        ],
      ),
      body: Column(
        children: [
          ToggleButtons(
            children: optionButtons,
            isSelected: options,
            onPressed: handleOptionPressed,
          ),
          Expanded(
            child: Center(
              child: AnimatedSwitcher(
                transitionBuilder: (child, animation) {
                  if (options[0]) {
                    return ScaleTransition(scale: animation, child: child);
                  } else if (options[1]) {
                    return RotationTransition(turns: animation, child: child);
                  } else {
                    return FadeTransition(opacity: animation, child: child);
                  }
                },
                duration: defaultDuration,
                child: toggled ? toggledWidget : untoggledWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
