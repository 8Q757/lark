class ConstURL {
  static var defaultLogo =
      'https://cdn.nlark.com/yuque/0/2019/png/84147/1547032500238-d93512f4-db23-442f-b4d8-1d46304f9673.png';
  static var accessToken = 'http://lark.oever.cn/api/callback';
  static var loginURL =
      'https://www.yuque.com/oauth2/authorize?client_id=hyeRb53dW9YdzMJGn5yI&scope=doc,repo,group:read&redirect_uri=http://localhost:51314/api/callback?state=0&response_type=code';

  static var selections = '/explore/selections';

  static var recommends = '/explore/recommends';

  static var docs = '/explore/docs';

  static String about(var slug) => '/v2/repos/veneris/yqapp/docs/$slug';

  static String myBooks(var id, var offset, var limit) =>
      '/v2/users/$id/repos?offset=$offset&limit=$limit';

  static String myGroups(var id, var offset, var limit) =>
      '/v2/users/$id/groups?offset=$offset&limit=$limit';

  static String myDocs(var id, var offset, var limit) =>
      '/v2/repos/$id/docs?offset=$offset&limit=$limit';

  static String groupDocs(var id, var offset, var limit) =>
      '/v2/groups/$id/repos?offset=$offset&limit=$limit';

  static String doc(var bookId, var id, var raw) => raw != null
      ? '/v2/repos/$bookId/docs/$id?raw=$raw'
      : '/v2/repos/$bookId/docs/$id';

  static String book(var bookId) => '/v2/repos/$bookId';

  static String group(var repoId) => '/v2/groups/$repoId';

  static String createDoc(var bookId) => '/v2/repos/$bookId/docs';

  static String createGroupBook(var userId) => '/v2/groups/$userId/repos';

  static String createMyBook(var userId) => '/v2/users/$userId/repos';

  static String search(var q, var type, var offset) =>
      '/v2/search?q=$q&type=$type&offset=$offset';
}
