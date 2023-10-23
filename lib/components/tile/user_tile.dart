
part of "../components.dart";

class UserTile extends StatelessWidget {
  final SingleUserModel model;
  const UserTile({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // avatar
        CircleAvatar(
          backgroundImage: NetworkImage(model.avatar),
          radius: context.getDynamicWidth(8),
        ),
        Padding(
          padding: EdgeInsets.only(left: context.normalValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name & surname
              Text(model.nameSurname, style: AppFonts.pageDescriptionStyle,),
              // email
              Text(model.email, style: AppFonts.pageDescriptionStyle),
            ],
          ),
        ),
      ],
    );
  }
}
