abstract class Routes {
  static const root = '/root';
  static const start = '/start';
  static const continueWithEmail = '/continue-with-email';
  static const home = '/home';
  static const addNewCollection = '/addNewCollection';
  static const collection = '/collection';

  static const unauthenticatedPaths = [root, start];
  static const authenticatedPaths = [home, addNewCollection, collection];
}
