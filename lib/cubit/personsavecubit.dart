import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/persondaorepository.dart';

class PersonSaveCubit extends Cubit<void> {
  PersonSaveCubit() : super(0);

  var personDaoRepository = PersonDaoRepository();

  Future<void> saveContact(String name, String phone) async {
    await personDaoRepository.saveContact(name, phone);
  }
}
