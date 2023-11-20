import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/persondaorepository.dart';

class PersonDetailCubit extends Cubit<void> {
  PersonDetailCubit() : super(0);

  var personDaoRepository = PersonDaoRepository();

  Future<void> updateContact(String personId, String name, String phone) async {
    await personDaoRepository.updateContact(personId, name, phone);
  }
}
