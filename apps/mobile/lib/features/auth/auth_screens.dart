import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rajawali_mobile/features/auth/mobile_auth_controller.dart';
import 'package:rajawali_mobile/features/home/authenticated_shell.dart';

final class MobileAuthFlow extends StatelessWidget {
  const MobileAuthFlow({
    required this.controller,
    required this.environment,
    super.key,
  });

  final MobileAuthController controller;
  final String environment;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => switch (controller.stage) {
        MobileAuthStage.signedOut => LoginScreen(
          controller: controller,
          deviceName: mobileDeviceName(defaultTargetPlatform),
        ),
        MobileAuthStage.mfaRequired => MfaScreen(controller: controller),
        MobileAuthStage.authenticated => AuthenticatedShell(
          environment: environment,
          busy: controller.busy,
          onSignOut: controller.signOut,
        ),
      },
    );
  }
}

String mobileDeviceName(TargetPlatform platform) => switch (platform) {
  TargetPlatform.android => 'Rajawali Mobile Android',
  TargetPlatform.iOS => 'Rajawali Mobile iOS',
  _ => 'Rajawali Mobile',
};

final class LoginScreen extends StatefulWidget {
  const LoginScreen({
    required this.controller,
    required this.deviceName,
    super.key,
  });

  final MobileAuthController controller;
  final String deviceName;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await widget.controller.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      deviceName: widget.deviceName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Icon(
                            Icons.local_shipping_outlined,
                            color: colors.onPrimaryContainer,
                            size: 34,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Masuk ke Rajawali Operations',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gunakan akun employee aktif untuk mengakses pekerjaan lapangan.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: colors.outline),
                    ),
                    if (widget.controller.errorMessage case final message?) ...[
                      const SizedBox(height: 20),
                      _AuthError(message: message),
                    ],
                    const SizedBox(height: 28),
                    TextFormField(
                      key: const Key('login-email'),
                      controller: _emailController,
                      enabled: !widget.controller.busy,
                      autofillHints: const [AutofillHints.username],
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Email perusahaan',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      validator: (value) {
                        final email = value?.trim() ?? '';
                        if (email.isEmpty || !email.contains('@')) {
                          return 'Masukkan email yang valid.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const Key('login-password'),
                      controller: _passwordController,
                      enabled: !widget.controller.busy,
                      obscureText: _obscurePassword,
                      autofillHints: const [AutofillHints.password],
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          tooltip: _obscurePassword
                              ? 'Tampilkan password'
                              : 'Sembunyikan password',
                          onPressed: widget.controller.busy
                              ? null
                              : () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Password wajib diisi.'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      key: const Key('login-submit'),
                      onPressed: widget.controller.busy ? null : _submit,
                      icon: widget.controller.busy
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.login),
                      label: Text(
                        widget.controller.busy ? 'Memeriksa…' : 'Masuk',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Perangkat: ${widget.deviceName}',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: colors.outline),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class MfaScreen extends StatefulWidget {
  const MfaScreen({required this.controller, super.key});

  final MobileAuthController controller;

  @override
  State<MfaScreen> createState() => _MfaScreenState();
}

final class _MfaScreenState extends State<MfaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _credentialController = TextEditingController();

  @override
  void dispose() {
    _credentialController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await widget.controller.verifyMfa(_credentialController.text);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        size: 58,
                        color: colors.primary,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Verifikasi dua langkah',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Masukkan kode authenticator 6 digit atau recovery code.',
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: colors.outline),
                      ),
                      if (widget.controller.errorMessage
                          case final message?) ...[
                        const SizedBox(height: 20),
                        _AuthError(message: message),
                      ],
                      const SizedBox(height: 28),
                      TextFormField(
                        key: const Key('mfa-credential'),
                        controller: _credentialController,
                        enabled: !widget.controller.busy,
                        autofocus: true,
                        autocorrect: false,
                        enableSuggestions: false,
                        textAlign: TextAlign.center,
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        decoration: const InputDecoration(
                          labelText: 'Kode keamanan',
                          hintText: '123456',
                        ),
                        validator: (value) {
                          final credential = value?.trim() ?? '';
                          if (credential.length < 6 || credential.length > 64) {
                            return 'Masukkan kode keamanan yang valid.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        key: const Key('mfa-submit'),
                        onPressed: widget.controller.busy ? null : _submit,
                        child: widget.controller.busy
                            ? const SizedBox.square(
                                dimension: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Verifikasi'),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        key: const Key('mfa-cancel'),
                        onPressed: widget.controller.busy
                            ? null
                            : widget.controller.signOut,
                        child: const Text('Batalkan login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _AuthError extends StatelessWidget {
  const _AuthError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      liveRegion: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.errorContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.error_outline, color: colors.onErrorContainer),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: colors.onErrorContainer),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
