
part of "../components.dart";

class LoadingArea extends StatelessWidget {
  final Widget child;
  const LoadingArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, bool>(
      builder:(context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            child,
            Visibility(
              visible: state,
              child: Container(color: Colors.black.withOpacity(.25))),
            Visibility(
              visible: state,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoadingAnimationWidget.beat(color: context.currentThemeData.colorScheme.primary, size: context.getDynamicWidth(12)),
                  ],
                ),
              ),
            ),
          ],
        );
        }
    );
  }
}