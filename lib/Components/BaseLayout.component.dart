import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isoja/Utils/Tema.dart';

class BaseLayoutComponent extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final bool useSafeArea;
  final EdgeInsetsGeometry? padding;

  const BaseLayoutComponent({
    super.key,
    required this.child,
    this.appBar,
    this.useSafeArea = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = Tema.primaryGradient;

    Widget content =
        padding != null ? Padding(padding: padding!, child: child) : child;

    if (useSafeArea) {
      content = SafeArea(child: content);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor, // 👈 evita flash branco
        appBar: appBar,
        body: Stack(
          children: [
            // 👇 FUNDO (não pisca mais)
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(gradient: gradient),
              ),
            ),

            // 👇 CONTEÚDO
            content,
          ],
        ),
      ),
    );
  }
}
