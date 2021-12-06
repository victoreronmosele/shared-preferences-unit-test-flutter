import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_unit_tests_flutter/shared_preferences_util.dart';
import 'package:test/test.dart';

main() {
  group(SharedPreferencesUtil, () {
    group('getCounter', () {
      test('returns 0 if no value is stored in SharedPreferences', () async {
        SharedPreferences.setMockInitialValues({});

        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        final SharedPreferencesUtil sharedPreferencesUtil =
            SharedPreferencesUtil(sharedPreferences: sharedPreferences);

        const expectedCounter = 0;
        final actualCounter = sharedPreferencesUtil.getCount();

        expect(expectedCounter, actualCounter);
      });

      test('returns the correct value stored in SharedPreferences', () async {
        const counterValue = 42;
        SharedPreferences.setMockInitialValues(
            {SharedPreferencesUtil.countKey: counterValue});
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        final SharedPreferencesUtil sharedPreferencesUtil =
            SharedPreferencesUtil(sharedPreferences: sharedPreferences);

        const expectedCount = counterValue;
        final actualCounter = sharedPreferencesUtil.getCount();
        expect(expectedCount, actualCounter);
      });
    });

    group('setCounter', () {
      test('stores the correct count value in SharedPreferences', () async {
        SharedPreferences.setMockInitialValues({});
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        final SharedPreferencesUtil sharedPreferencesUtil =
            SharedPreferencesUtil(sharedPreferences: sharedPreferences);
        const countValue = 42;

        sharedPreferencesUtil.setCount(countValue);
        const expectedCounter = countValue;
        final actualCounter =
            sharedPreferences.getInt(SharedPreferencesUtil.countKey);

        expect(expectedCounter, actualCounter);
      });
    });
  });
}
