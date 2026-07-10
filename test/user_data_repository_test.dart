import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/data/repositories/user_data_repository.dart';
import 'package:peptide_os/data/repositories/user_settings_repository.dart';
import 'package:peptide_os/models/user_settings.dart';

void main() {
  group('UserDataRepository', () {
    late FakeFirebaseFirestore firestore;
    late UserDataRepository repository;

    setUp(() {
      firestore = FakeFirebaseFirestore();
      repository = UserDataRepository(firestore: firestore, batchSize: 2);
    });

    test(
      'app reset deletes tracking data in batches and preserves identity',
      () async {
        const uid = 'target-user';
        const otherUid = 'other-user';
        final user = firestore.collection('users').doc(uid);
        final otherUser = firestore.collection('users').doc(otherUid);

        await user.set({'email': 'target@example.com'});
        await user.collection('settings').doc('profile').set({
          'onboardingCompleted': true,
          'subscriptionState': 'premium',
          'reviewAccount': true,
        });
        for (var index = 0; index < 5; index++) {
          await user.collection('protocols').doc('protocol-$index').set({
            'index': index,
          });
        }
        await user.collection('doseLogs').doc('dose-1').set({'taken': true});
        await user.collection('bodyMetrics').doc('metric-1').set({
          'weight': 80,
        });
        await otherUser.set({'email': 'other@example.com'});
        await otherUser.collection('protocols').doc('keep-me').set({
          'ok': true,
        });
        await firestore.collection('peptideLibrary').doc('bpc-157').set({
          'name': 'BPC-157',
        });

        await repository.deleteAppDataForUser(uid);

        expect((await user.get()).exists, isTrue);
        expect(
          (await user.collection('settings').doc('profile').get()).exists,
          isTrue,
        );
        expect((await user.collection('protocols').get()).docs, isEmpty);
        expect((await user.collection('doseLogs').get()).docs, isEmpty);
        expect((await user.collection('bodyMetrics').get()).docs, isEmpty);
        expect(
          (await otherUser.collection('protocols').doc('keep-me').get()).exists,
          isTrue,
        );
        expect(
          (await firestore.collection('peptideLibrary').doc('bpc-157').get())
              .exists,
          isTrue,
        );

        await repository.deleteAppDataForUser(uid);
        expect((await user.get()).exists, isTrue);
      },
    );

    test('account deletion still removes settings and user root', () async {
      const uid = 'delete-me';
      final user = firestore.collection('users').doc(uid);
      await user.set({'email': 'delete@example.com'});
      await user.collection('settings').doc('profile').set({'active': true});
      await user.collection('protocols').doc('protocol').set({'active': true});

      await repository.deleteAllForUser(uid);

      expect((await user.get()).exists, isFalse);
      expect((await user.collection('settings').get()).docs, isEmpty);
      expect((await user.collection('protocols').get()).docs, isEmpty);
    });

    test('rejects invalid batch sizes at runtime', () {
      expect(
        () => UserDataRepository(firestore: firestore, batchSize: 0),
        throwsRangeError,
      );
      expect(
        () => UserDataRepository(firestore: firestore, batchSize: 501),
        throwsRangeError,
      );
    });
  });

  test('settings reset preserves account-level flags only', () async {
    final firestore = FakeFirebaseFirestore();
    final repository = UserSettingsRepository(firestore: firestore);
    const uid = 'settings-user';
    await repository.save(
      uid,
      UserSettings(
        name: 'Joe',
        onboardingCompleted: true,
        notificationsEnabled: true,
        subscriptionState: 'premium',
        reviewAccount: true,
      ),
    );

    await repository.reset(
      uid,
      subscriptionState: 'premium',
      reviewAccount: true,
    );

    final reset = await repository.fetch(uid);
    expect(reset.name, 'Biohacker');
    expect(reset.onboardingCompleted, isFalse);
    expect(reset.notificationsEnabled, isFalse);
    expect(reset.subscriptionState, 'premium');
    expect(reset.reviewAccount, isTrue);
  });
}
