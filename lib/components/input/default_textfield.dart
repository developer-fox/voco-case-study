
part of "../components.dart";

class _WidgetForBlocProvider extends StatefulWidget {
  final double borderRadius;
  final int? minLength;
  final String labelText;
  final String? errorText;
  final IconData? suffixIcon;
  final bool? obscureText;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? suffixIconsize;
  final void Function()? onSuffix;
  final EdgeInsets? contentPadding;
  final double? inputHeight;
  final TextInputType? inputType;
  const _WidgetForBlocProvider({
    Key? key,
    required this.borderRadius,
    this.minLength,
    required this.labelText,
    this.errorText,
    this.suffixIcon,
    this.obscureText,
    this.onChanged,
    this.validator,
    this.controller,
    this.focusNode,
    this.suffixIconsize,
    this.onSuffix,
    this.contentPadding,
    this.inputHeight,
    this.inputType,
  }) : super(key: key);

  @override
  State<_WidgetForBlocProvider> createState() => __WidgetForBlocProviderState();
}

class __WidgetForBlocProviderState extends BaseState<_WidgetForBlocProvider> {
  late FocusNode focusNode;


  @override
  void initState() {
    super.initState();
    focusNode= widget.focusNode ?? FocusNode();
    focusNode.addListener(() { 
      if(focusNode.hasFocus){
        context.read<DefaultTextFieldCubit>().changeSuffixColor(currentThemeData.colorScheme.primary);
      }
      else{
        context.read<DefaultTextFieldCubit>().changeSuffixColor(currentThemeData.primaryColorLight);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefaultTextFieldCubit, Color>(
      builder: (context, state) {
        return AnimatedBuilder(
          animation: focusNode,
          builder: (context, child) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: context.lowValue * .5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: focusNode.hasFocus ? context.currentThemeData.colorScheme.primary : const Color.fromRGBO(236, 236, 236, 1)
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              height: widget.inputHeight,
              child: TextFormField(
                textInputAction: TextInputAction.done,
                focusNode: focusNode,
                keyboardType: widget.inputType,
                validator: widget.validator,
                style: AppFonts.textFieldInputStyle,
                obscureText: widget.obscureText ?? false,
                controller: widget.controller,
                minLines: widget.minLength,
                onChanged: widget.onChanged,
                maxLines: widget.minLength == null ? 1: 12,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: !focusNode.hasFocus ? null : widget.labelText,
                  labelStyle: AppFonts.textFieldLabelStyle,
                  suffixIcon: widget.suffixIcon == null ? null : GestureDetector(
                    onTap: widget.onSuffix,
                    child: Icon(widget.suffixIcon, color: state, size: widget.suffixIconsize ?? 22),
                  ),
                  hintStyle: AppFonts.textFieldHintStyle,
                  hintText: focusNode.hasFocus ? null : widget.labelText,
                  contentPadding: EdgeInsets.only(left: context.lowValue, bottom: 14, top: 4),
                ),
              ),
            );
          }
        );
      },
    );  }
}

class DefaultTextField extends StatefulWidget {
  final double borderRadius;
  final double? inputHeight;
  final int? minLength;
  final String labelText;
  final IconData? suffixIcon;
  final void Function(String value)? onChanged;
  final String?  errorText;
  final bool? obscureText;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? suffixIconsize;
  final void Function()? onSuffix;
  final EdgeInsets? contentPadding;
  final TextInputType? inputType;
  const DefaultTextField({
    Key? key,
    this.borderRadius = 5,
    this.inputHeight = 70,
    this.minLength,
    required this.labelText,
    this.suffixIcon,
    this.onChanged,
    this.errorText,
    this.obscureText,
    this.validator,
    this.controller,
    this.focusNode,
    this.suffixIconsize,
    this.onSuffix,
    this.contentPadding,
    this.inputType,
  }) : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends BaseState<DefaultTextField> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DefaultTextFieldCubit(currentThemeData.primaryColorLight),
      child: _WidgetForBlocProvider(labelText: widget.labelText, controller: widget.controller, focusNode: widget.focusNode,suffixIcon: widget.suffixIcon, validator: widget.validator, obscureText: widget.obscureText,suffixIconsize: widget.suffixIconsize, onSuffix: widget.onSuffix, borderRadius: widget.borderRadius, minLength: widget.minLength, contentPadding: widget.contentPadding,errorText:  widget.errorText,onChanged: widget.onChanged,inputHeight: widget.inputHeight,inputType: widget.inputType,),
    );
  }
}

class DefaultTextFieldCubit extends Cubit<Color> {
  DefaultTextFieldCubit(super.initialState);

  void changeSuffixColor(Color color) {
    emit(color);
  }
}
