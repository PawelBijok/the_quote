abstract class Routes {
  static const root = '/root';
  static const start = '/start';
  static const continueWithEmail = '/continue-with-email';
  static const main = '/main';
  static const addOrEditCollection = '/addNewCollection';
  static const collection = '/collection';
  static const addOrEditQuote = '/addOrEditQuote';

  static const unauthenticatedPaths = [root, start];
  static const authenticatedPaths = [main, addOrEditCollection, collection, addOrEditQuote];
}
