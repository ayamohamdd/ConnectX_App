import 'package:gsheets/gsheets.dart';

class UserSheetApi {
  static final _credentials = r'''
  {
  "type": "service_account",
  "project_id": "gsheet-401008",
  "private_key_id": "b01a10ff69fa4a81a07bc4645e1f6d3318d1dfd5",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCokC62olPHbVcI\n5U7jQnythkZA5ZKrJaK4pEj1IXUvy8KpYUE+kxoGnSN+73pguMxIhmW8vOexjvHF\nSOJ47rikpn5xv0kDo4x1br4aEdwoiXRQ/cVNVp5AgCVp+EJyl+vqxM9WlFsCHjzM\n1PGTxtMUNrJG9gR/rrlRtOPbpYhbpaeMDWNrwWVmVI8GvGt1osNGdR61PjRwNK/L\nUCTQiswTXCL/+KqlPtC2qXtlbjQmY/s4PSAtkCnoZHNheHG8gnvQMOPc8Pis+ubj\nxrtdhk+FXj0AoJOMM3ugpiHKIi/v6e/ui3nDHJ89pVoldMEHoCBCFeNk6GVFsMBi\n0+T4GBMPAgMBAAECggEAQ3t9iBZSjgtjBaevvmG2wk14QLDn1+a4T01N+/0KCjl7\n1A2gbim8CJvOQxoilyhEeGB9yGKkKzx75Cx6pkmD2D7jbixTUcafC8BrEMrHpd7p\nlycRXxXnQxFKaTM/ftr9Ur659wJrsNxkIOi7UhsOFBCVrLz/LhLIFELj2eJaRb3T\nUPV5+Q23wG/DHFX3mb8vFrg8elBRHWj66qPNOOAWYuMn5snZ17zUcSy9H/c8kU7q\ni27JMYkvfL8cRCPlGbZSbNyemgwHU/Spaw6uM0fyONwT6VvHt416BPQsj4U5NRXM\nuIKhfgGlR4GudnP23RiDPrfZk1rmmexALfioyyiTQQKBgQDq48+H1NDbHtPmtZ4m\nA2Qk++vJN2Z19EvHXJDTrfJ2IpjAdWPRWJG510tbrTDVmCoDAyWpZLGqXesoq7gz\niRGT/fdVWcexpYWVhH5Ftuy+/auEdN3nd9SNFxT/UDaXrjfnZIB53V3JlM7d7vwB\nk5HfDkpr6iUnRIoPBhAK4BPH7wKBgQC3tl9B44lohxDYIFJYnLrHzJ3P+m9CePZS\nJ90qZHQGzMr35UH0hDKncfLSJxj/v8nSU5RopK+JWPq4nN5U9WaKw82grHyUtNqT\nFvsrkIwQwGJ11OTNW7G01rmfQSUqOzTyoZprvNoD8j3h+C1tyO4U83vsTPeoi5QC\n+rJmCJZG4QKBgQDYyk+1dycYxhgfXErNnN2mANk7CqXHgiUaqIWGyYn5nK7NGst4\n4T0Gf/2ubGehC+LiitoMwMH1kt9C11KYRg7yPzkzDjzv6ewj9ngw0ccp86iFBPP1\n+bQ0UDRx/E+WqRYxu6GUWEqCjZRsY3E150R/0YnAlgeaeXjOqvLNhsjbAwKBgQCc\naBQpkILID1Xz63CwKJ+Mw1QIYXqf6UQtJetR0DxIHcsfynugpXxKuuS0rrzF4I7/\nFlFf1fXsxWiQDF3tjxBCS/mhNbjLEj6UxBgLOwFEscYh86Log4yEHdvjDh+KGOY3\nPAawexRSD8dHv3dN5KduBu4WfGDNiif1cWK5I85tgQKBgAgB7Q3N48Mky9AvXgk5\nUdB9xJgp6qbZm340+vmOuIMeHVfa2KKCWFWE4uvMpO6lYpV2C1Ru/2agRVDBTokN\nfeo2zmENwOvKhB1LT/w7BV37pAHHX+oiT4+F0bShLtYzIzJUvDbWW21OhAiwXp4K\ny+Z50zPtOl1yATwjhyjFeoLt\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheet@gsheet-401008.iam.gserviceaccount.com",
  "client_id": "111011311362523642330",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheet%40gsheet-401008.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

  ''';
  static final _spreadSheetId = '1TItYH0NTuGNc9Zy0BWKBasMGxs_yHGthwiyRes5l-fY';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  static Future init() async {
    final spreedSheet = await _gsheets.spreadsheet(_spreadSheetId);
    _userSheet = await _getWorkSheet(spreedSheet, title: 'Sheet1');
    final firstRow = ['Name', 'Attendance', 'Date'];
    _userSheet!.values.insertRow(1, firstRow);
  }

  static Future<Worksheet> _getWorkSheet(spreedSheet,
      {required String title}) async {
    try {
      return await spreedSheet.addWorkSheet(title);
    } catch (e) {
      return spreedSheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<dynamic> row) async {
    if (_userSheet == null) {
      return;
    } else {
      _userSheet!.values.appendRow(row);
    }
  }
}
