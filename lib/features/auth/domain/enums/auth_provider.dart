enum AppAuthProvider {
  google('Google'),
  apple('Apple');

  const AppAuthProvider(this.uiName);

  final String uiName;
}
