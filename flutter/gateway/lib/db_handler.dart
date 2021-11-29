import 'package:mysql1/mysql1.dart';

class DbHandler {
  DbHandler._();

  static final DbHandler instance = DbHandler._();
  factory DbHandler() => instance;

  var settings = ConnectionSettings(
    host: '192.168.1.26',
    port: 3306,
    user: 'root',
    password: '',
    db: 'gateway',
  );

  MySqlConnection? connection;

  Future<bool> connect() => MySqlConnection.connect(settings)
          .then((value) => connection = value)
          .then((value) {
        // ignore: avoid_print
        print("connected");
        return true;
      }).onError((_, __) {
        // ignore: avoid_print
        print("connect error");
        return false;
      });

  getPins() {
    if (connection != null) {
      connection!.query('select * from controller where id = ?', [0]).then(
          // ignore: avoid_print
          (value) => print(value));
    }
  }
}
