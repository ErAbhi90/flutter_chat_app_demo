import 'package:flutter_chat_app_demo/app_settings/settings.dart';
import 'package:flutter_chat_app_demo/screens/profile/profile_screen_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _buildProfilePhoto(ProfileScreenViewModel vm) {
    return Stack(
      children: [
        CircleAvatar(
          maxRadius: 42.0,
          child: vm.displayImage(),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          height: 30,
          child: GestureDetector(
            child: Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.edit,
                color: AppColors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCompleteBtn(ProfileScreenViewModel vm) {
    return GestureDetector(
      child: Container(
        width: 295,
        height: 44,
        margin: const EdgeInsets.only(
          top: 60,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Complete",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutBtn(BuildContext context, ProfileScreenViewModel vm) {
    return GestureDetector(
      onTap: () => vm.showAlertDialog(context),
      child: Container(
        width: 295,
        height: 44,
        margin: const EdgeInsets.only(
          top: 0,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          color: AppColors.secondaryText,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Logout",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileScreenViewModel>(
      create: (_) => ProfileScreenViewModel(),
      child: Consumer<ProfileScreenViewModel>(
          builder: (context, vm, _) => CustomScrollView(
                slivers: [
                  const SliverAppBar(
                    pinned: true,
                    title: Text(
                      AppStrings.profile,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Column(
                    children: [
                      _buildProfilePhoto(vm),
                      _buildCompleteBtn(vm),
                      _buildLogoutBtn(context, vm),
                    ],
                  )),
                ],
              )),
    );
  }
}
