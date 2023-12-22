import 'package:injectable/injectable.dart';

import '../../../../../data/mapper/base/data_mapper.dart';
import '../../domain/entities/account_entity.dart';
import '../models/account_model.dart';

@injectable
class AccountEntityMapper extends BaseDataMapper<AccountModel, AccountEntity> {
  @override
  AccountEntity mapToEntity(AccountModel? data) {
    return AccountEntity(
      
      // code: data?.code,
    );
  }
}
