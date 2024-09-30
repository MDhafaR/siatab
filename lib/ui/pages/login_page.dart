part of 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height;
    final topHeight = MediaQuery.of(context).padding.top;
    final bottomHeight = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: bodyHeight - topHeight - bottomHeight,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.cover)),
            padding: EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(36.r)),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 36.h),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/logo.png"),
                          )),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "SIATAB",
                          style: AppTheme.logo,
                        ),
                        Text(
                          "Sistem Informasi air tanah dan air baku",
                          style: AppTheme.caption1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Silahkan Login dengan akun Anda",
                    style: AppTheme.body,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Email",
                    style: AppTheme.medium,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    validator: (text) {
                      bool isEmail(String input) =>
                          EmailValidator.validate(input);
                      if (text!.isEmpty) {
                        return "Email cannot be empty.";
                      } else if (!isEmail(text)) {
                        return "Email is not valid.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Example@gmail.com",
                      hintStyle: AppTheme.caption2,
                      prefixIcon: Icon(Icons.mail_outline_outlined),
                      prefixIconColor: AppColor.light,
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColor.superLight,
                          )),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColor.superLight,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColor.primary,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    "Kata Sandi",
                    style: AppTheme.medium,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: _obscureText,
                    controller: _passwordController,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Password cannot be empty.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "********",
                      hintStyle: AppTheme.caption2,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(Icons.remove_red_eye_outlined),
                      ),
                      suffixIconColor:
                          _obscureText ? AppColor.light : AppColor.primary,
                      prefixIcon: Icon(Icons.lock_outlined),
                      prefixIconColor: AppColor.light,
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColor.superLight,
                          )),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColor.superLight,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColor.primary,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {},
                        child: Text("Lupa kata sandi?",
                            style: AppTheme.caption2
                                .copyWith(color: AppColor.primary))),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                      style: ButtonStyle(
                          minimumSize: WidgetStateProperty.all(
                              Size(double.infinity, 46.h)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                          backgroundColor: WidgetStateProperty.all(
                            AppColor.primary,
                          )),
                      onPressed: () {
                        Get.off(() => const MainPage());
                      },
                      child: _isLoading
                          ? SizedBox(
                              height: 24.r,
                              width: 24.r,
                              child: const CircularProgressIndicator(
                                color: AppColor.white,
                                strokeWidth: 2.0,
                              ))
                          : Text("Masuk", style: AppTheme.button)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum punya akun? ",
                        style: AppTheme.caption3,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(0),
                            padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                        onPressed: () {},
                        child: Text("Daftar",
                            style: AppTheme.caption3
                                .copyWith(color: AppColor.primary)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
