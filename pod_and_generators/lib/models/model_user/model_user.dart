// ignore_for_file: non_constant_identifier_names

import 'package:xyz_gen/xyz_gen.dart';

part '_model_user.g.dart';

@GenerateModel(
  className: "ModelUser",
  parameters: {
    "id": "String?",
    "userPubId": "String?",
    "role": "String?",
  },
)
abstract class _ModelUser extends Model {
  _ModelUser._();
}
