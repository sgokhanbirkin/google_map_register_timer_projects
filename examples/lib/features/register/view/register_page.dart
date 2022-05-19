import 'package:dio/dio.dart';
import 'package:examples/features/register/view/registerion_completed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/validators/register_validation.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/password_text_field.dart';
import '../cubit/register_cubit.dart';
import '../service/register_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;
  late TextEditingController _phoneController;

  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _passwordConfirmFocusNode;
  late FocusNode _phoneFocusNode;
  late FocusNode _buttonFocusNode;

  final String baseUrl = 'https://reqres.in/api';

  final String title = 'Register Page';
  final String title2 = 'Register User';

  final String buttonText = 'Register';
  final String nameLabel = 'Name';
  final String emailLabel = 'Email';
  final String paswordLabel = 'Password';
  final String passwordConfirmLabel = 'Confirm Password';
  final String phoneLabel = 'Phone';

  final String errorMessage = 'Register Failure';
  final String errorEmail = 'Email should be eve.holt@reqres.in';
  final String errorPassword = 'Password should be pistol';
  final String tryAgainText = 'Try Again';

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    _phoneController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordConfirmFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _buttonFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _phoneController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordConfirmFocusNode.dispose();
    _phoneFocusNode.dispose();
    _buttonFocusNode.dispose();

    super.dispose();
  }

  void clearControllersText() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _passwordConfirmController.clear();
    _phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var registerService = RegisterService(dio: Dio(BaseOptions(baseUrl: baseUrl)));
    return BlocProvider(
      create: (_) {
        return RegisterCubit(
          service: registerService,
          formKey: _formKey,
          nameController: _nameController,
          emailController: _emailController,
          passwordController: _passwordController,
          passwordConfirmController: _passwordConfirmController,
          phoneController: _phoneController,
        );
      },
      child: _blocConsumer(),
    );
  }

  BlocConsumer<RegisterCubit, RegisterState> _blocConsumer() {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterCompleted) {
          var tempModel = state.model;
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => RegisterionCompletedPage(model: tempModel),
            ),
            (_) => false,
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            if (state is RegisterInitial || state is RegisterLoading) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(title),
                  centerTitle: true,
                ),
                body: Center(
                  child: state is RegisterInitial ? _registerForm(context) : _loadingCircular(),
                ),
              );
            }
            if (state is RegisterFailure) {
              return _registerFailure(context);
            }
            return Container();
          },
        );
      },
    );
  }

  Scaffold _registerFailure(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage),
            Text(errorEmail),
            Text(errorPassword),
            ElevatedButton(
              onPressed: () {
                clearControllersText();
                context.read<RegisterCubit>().tryAgain();
              },
              child: Text(tryAgainText),
            ),
          ],
        ),
      ),
    );
  }

  Center _loadingCircular() => const Center(child: CircularProgressIndicator());

  Widget _registerForm(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.1),
                child: Text(
                  title2,
                  style: theme.textTheme.headline3,
                ),
              ),
              CustomTextField(
                inputType: TextInputType.text,
                controller: _nameController,
                labelText: nameLabel,
                icon: Icons.person,
                focusNode: _nameFocusNode,
                nextFocusNode: _emailFocusNode,
                validator: RegisterValidation().nameValidation,
              ),
              CustomTextField(
                inputType: TextInputType.emailAddress,
                controller: _emailController,
                focusNode: _emailFocusNode,
                nextFocusNode: _passwordFocusNode,
                labelText: emailLabel,
                icon: Icons.email,
                validator: RegisterValidation().emailValidator,
              ),
              PasswordTextField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                nextFocusNode: _passwordConfirmFocusNode,
                labelText: paswordLabel,
                obscureText: true,
                validator: RegisterValidation().passwordValidation,
                icon: Icons.lock,
              ),
              PasswordTextField(
                controller: _passwordConfirmController,
                focusNode: _passwordConfirmFocusNode,
                nextFocusNode: _phoneFocusNode,
                labelText: passwordConfirmLabel,
                obscureText: true,
                icon: Icons.lock,
              ),
              CustomTextField(
                inputType: TextInputType.number,
                focusNode: _phoneFocusNode,
                nextFocusNode: _buttonFocusNode,
                controller: _phoneController,
                labelText: phoneLabel,
                icon: Icons.phone,
              ),
              ElevatedButton(
                focusNode: _buttonFocusNode,
                onPressed: () {
                  if (_passwordConfirmController.text != _passwordController.text) {
                    _passwordConfirmFocusNode.unfocus();
                    _passwordFocusNode.unfocus();
                    _passwordConfirmController.clear();
                    _passwordController.clear();
                    _passwordConfirmFocusNode.requestFocus();
                    ScaffoldMessenger.of(context).showSnackBar(snacBar);
                    return;
                  }
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    context.read<RegisterCubit>().postUserData();
                  }
                },
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final SnackBar snacBar = const SnackBar(
    content: Text('Password and confirm password not match! Please try again'),
  );
}
