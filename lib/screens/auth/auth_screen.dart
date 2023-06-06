import 'package:flutter_chat_app_demo/app_settings/settings.dart';
import 'package:flutter_chat_app_demo/screens/auth/auth_screen_view_model.dart';
import 'package:flutter_chat_app_demo/widgets/image_picker/user_image_picker.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      backgroundColor: AppColors.backgroundColor,
    );

    final appLogo = Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 5.2,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(AppImages.logo),
        ),
      ),
    );

    const appTitleText = Text(
      AppStrings.appTitle,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryColor,
      ),
    );

    final googleIcon = Padding(
      padding: const EdgeInsets.all(4.0),
      child: Image.network(
        AppImages.googleIcon,
        width: 30,
        height: 50,
      ),
    );

    const divider = Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('or'),
          ),
          Expanded(
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );

    Widget authForm(AuthScreenViewModel vm) => Form(
        key: vm.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!vm.isLogin)
                UserImagePicker(
                  onPickedImage: vm.setImage,
                ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                onSaved: vm.setEmail,
                validator: vm.validateEmail,
              ),
              const SizedBox(height: 10),
              if (!vm.isLogin)
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  onSaved: vm.setUsername,
                  validator: vm.validateUsername,
                ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                onSaved: vm.setPassword,
                validator: vm.validatePassword,
              ),
              const SizedBox(height: 20),
              if (vm.isAuthenticating) const CircularProgressIndicator.adaptive(),
              if (!vm.isAuthenticating)
                ElevatedButton(
                  onPressed: () => vm.onSubmit(context),
                  child: Text(vm.isLogin ? 'Login' : 'Sign Up'),
                ),
              const SizedBox(height: 10),
              if (!vm.isAuthenticating)
                TextButton(
                  onPressed: vm.textBtnPressed,
                  child: Text(vm.isLogin ? 'Create an account' : 'I already have an account Login.'),
                ),
            ],
          ),
        ));

    return ChangeNotifierProvider<AuthScreenViewModel>(
      create: (_) => AuthScreenViewModel(),
      child: Consumer<AuthScreenViewModel>(
        builder: (context, vm, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  appLogo,
                  appTitleText,
                  const SizedBox(height: 10),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: authForm(vm),
                  ),
                  const SizedBox(height: 10),
                  divider,
                  const SizedBox(height: 0),
                  ElevatedButton(
                    style: style,
                    onPressed: () => vm.onGoogleSignInPressed(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        googleIcon,
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(AppStrings.googleSignIn),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
