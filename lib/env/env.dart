import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GEMINI_API_KEY')
  static const String geminiApiKey = _Env.geminiApiKey;

  @EnviedField(varName: 'OPENAI_API_KEY')
  static const String openaiApiKey = _Env.openaiApiKey;
  
  @EnviedField(varName: 'OPENAI_ORGANISATION_ID')
  static const String openaiOrganisationId = _Env.openaiOrganisationId;
}
