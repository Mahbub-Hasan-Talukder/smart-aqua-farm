import '../../../../../core/services/local/hive_services.dart';
import '../../../../../core/di/di.dart';
import 'auth_local.dart';

class AuthLocalImpl implements AuthLocal {
  @override
  Future<String> getUserEmail() async {
    final localAgent = getIt<HiveServices>();
    final userEmail = await localAgent.getValue<String>(
      key: 'email',
      boxName: HiveServices.authBox,
    );
    return userEmail ?? 'No email found';
  }

  @override
  Future<String> getUserId() async {
    final localAgent = getIt<HiveServices>();
    final userId = await localAgent.getValue<String>(
      key: 'userId',
      boxName: HiveServices.authBox,
    );
    return userId ?? 'No id found';
  }

  @override
  Future<String> getUserName() async {
    final localAgent = getIt<HiveServices>();
    final userName = await localAgent.getValue<String>(
      key: 'userName',
      boxName: HiveServices.authBox,
    );
    return userName ?? 'No name found';
  }

  @override
  Future<void> saveUser(Map<String, dynamic> user) async {
    final localAgent = getIt<HiveServices>();
    await localAgent.setValue(
      key: 'userName',
      value: user['name'],
      boxName: HiveServices.authBox,
    );
    await localAgent.setValue(
      key: 'userEmail',
      value: user['email'],
      boxName: HiveServices.authBox,
    );
    await localAgent.setValue(
      key: 'userId',
      value: user['id'],
      boxName: HiveServices.authBox,
    );
  }
}
