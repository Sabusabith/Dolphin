import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveObject(key, value) async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  await sf.reload();
  return sf.setBool(key, value);
}

saveName(key, value) async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  await sf.reload();
  return sf.setString(key, value);
}

getSavedName(
  key,
) async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  await sf.reload();
  return sf.getString(key);
}

getSavedObject(
  key,
) async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  await sf.reload();
  return sf.getString(key);
}
