
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab05_study_notes/data/auth_repository.dart';

void main() {
  setUpAll(FakeFirebaseFirestore.new);

  test('example: messageFor maps weak-password', () {
    expect(
      AuthRepository.messageFor('weak-password'),
      contains('6 characters'),
    );
  });

  test('messageFor maps network-request-failed', () {
    expect(
      AuthRepository.messageFor('network-request-failed'),
      'No connection. Check your network.',
    );
  });

  test('messageFor maps invalid-email', () {
    expect(
      AuthRepository.messageFor('invalid-email'),
      'The email address is not valid.',
    );
  });
}
