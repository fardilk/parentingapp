import 'package:flutter/material.dart';
import 'package:grouu/ui/register/widgets/register_rounded_top_right.dart';

class RegisterContentContainer extends StatelessWidget {
  const RegisterContentContainer({
    super.key,
    required this.child,
    required this.appBar,
  });

  final Widget child;
  final PreferredSizeWidget appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: appBar,
      body: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              RegisterRoundedTopRight(),
              ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
