
part of "../components.dart";

class AuthenticationButton extends StatefulWidget {
  final String title;
  final void Function()? onPressed;
  const AuthenticationButton({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  State<AuthenticationButton> createState() => _AuthenticationButtonState();
}

class _AuthenticationButtonState extends BaseState<AuthenticationButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       width: double.maxFinite,
       height: context.getDynamicWidth(12.8),
       child: ElevatedButton(
         onPressed: widget.onPressed,
         style: ElevatedButton.styleFrom(
          elevation: 0,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(5),
           ),
          ),
          child: Text(widget.title, style: AppFonts.elevatedButtonTextStyle,),
        ),
    );
  }
}

