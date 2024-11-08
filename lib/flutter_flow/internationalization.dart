import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es', 'de', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
    String? deText = '',
    String? arText = '',
  }) =>
      [enText, esText, deText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // pagina_login
  {
    'o07j3mgv': {
      'en': 'Bem vindo',
      'ar': 'البدء',
      'de': 'Loslegen',
      'es': 'Empezar',
    },
    'fzxvw3mu': {
      'en': 'Faça login para acessar \nsua conta abaixo.',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'de': 'Erstellen Sie unten Ihr Konto.',
      'es': 'Crea tu cuenta a continuación.',
    },
    'a9j78va9': {
      'en': 'Endereço de Email',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'i7f18cve': {
      'en': 'Digite seu E-mail...',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'wztjmbn8': {
      'en': 'Senha',
      'ar': 'كلمة المرور',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    'lw1jpm1f': {
      'en': 'Digite sua Senha...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    'm2xyjvuf': {
      'en': 'Esqueceu sua senha?',
      'ar': 'هل نسيت كلمة السر؟',
      'de': 'Passwort vergessen?',
      'es': '¿Has olvidado tu contraseña?',
    },
    'qbmoi1av': {
      'en': 'Entrar',
      'ar': 'تسجيل الدخول',
      'de': 'Anmeldung',
      'es': 'Acceso',
    },
    'cjqb8ial': {
      'en': 'Não tem uma conta?',
      'ar': 'ليس لديك حساب؟',
      'de': 'Sie haben kein Konto?',
      'es': '¿No tienes una cuenta?',
    },
    'a0iimirx': {
      'en': 'Criar',
      'ar': 'ليس لديك حساب؟',
      'de': 'Sie haben kein Konto?',
      'es': '¿No tienes una cuenta?',
    },
    '2bb3vct7': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // Criar_Conta
  {
    'gpokmd81': {
      'en': 'Criar Conta',
      'ar': 'البدء',
      'de': 'Loslegen',
      'es': 'Empezar',
    },
    'oitrrwgg': {
      'en': 'Crie sua conta abaixo.',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'de': 'Erstellen Sie unten Ihr Konto.',
      'es': 'Crea tu cuenta a continuación.',
    },
    'gcwdqm4g': {
      'en': 'Endereço de Email',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'iam0xgwx': {
      'en': 'Digite seu E-mail...',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'bqv15dcf': {
      'en': 'Senha',
      'ar': 'كلمة المرور',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    'joih97mn': {
      'en': 'Digite sua Senha...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    'rzpiwq9p': {
      'en': 'Confirmar Senha',
      'ar': 'تأكيد كلمة المرور',
      'de': 'Kennwort bestätigen',
      'es': 'Confirmar contraseña',
    },
    'eyfkffka': {
      'en': 'Confirme sua Senha...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    '5kmjfwsk': {
      'en': 'Criar Conta',
      'ar': 'إنشاء حساب',
      'de': 'Benutzerkonto erstellen',
      'es': 'Crear una cuenta',
    },
    '3twynvfz': {
      'en': 'Login',
      'ar': 'هل لديك حساب؟',
      'de': 'Sie haben bereits ein Konto?',
      'es': '¿Ya tienes una cuenta?',
    },
    '9ssznj0g': {
      'en': 'Já tem uma conta?',
      'ar': 'هل لديك حساب؟',
      'de': 'Sie haben bereits ein Konto?',
      'es': '¿Ya tienes una cuenta?',
    },
    'momge5oj': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // Complete_perfil
  {
    'yhcaf7r2': {
      'en': 'Complete seu Perfil',
      'ar': 'الملف الشخصي الكامل',
      'de': 'Vollständiges Profil',
      'es': 'Perfil completo',
    },
    'r6npjsue': {
      'en': 'Carregue uma foto para que possamos identificá-lo facilmente.',
      'ar': 'قم بتحميل صورة لنا للتعرف عليك بسهولة.',
      'de':
          'Laden Sie ein Foto hoch, damit wir Sie leicht identifizieren können.',
      'es': 'Sube una foto para que te identifiquemos fácilmente.',
    },
    'sdptn7dd': {
      'en': 'Digite seu Nome',
      'ar': 'اسمك',
      'de': 'Dein Name',
      'es': 'Tu nombre',
    },
    'qjzhu60p': {
      'en': 'Digite seu Nome...',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n636qnrx': {
      'en': 'Digite sua Idade',
      'ar': 'عمرك',
      'de': 'Ihr Alter',
      'es': 'Su edad',
    },
    's7yvjzbs': {
      'en': 'Digite sua Idade...',
      'ar': 'أي 34',
      'de': 'dh 34',
      'es': 'es decir, 34',
    },
    'hbhd3bdt': {
      'en': 'Completar Perfil',
      'ar': 'الملف الشخصي الكامل',
      'de': 'Vollständiges Profil',
      'es': 'Perfil completo',
    },
    '1eac148w': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ew7dbn3s': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jhhlgzk5': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4k3jnl38': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // Esqueceu_Senha
  {
    'g416xg9f': {
      'en': 'Esqueceu sua senha',
      'ar': 'هل نسيت كلمة السر',
      'de': 'Passwort vergessen',
      'es': 'Has olvidado tu contraseña',
    },
    'gt66vvl7': {
      'en':
          'Digite o e-mail associado à sua conta e lhe enviaremos um código de verificação.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'u4nuk910': {
      'en': 'Seu Email',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    '37kotxi0': {
      'en': 'Digite seu Email...',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'hiwpaze1': {
      'en': 'Enviar link de redefinição',
      'ar': 'أرسل رابط إعادة التعيين',
      'de': 'Zurücksetzen-Link senden',
      'es': 'Enviar enlace de reinicio',
    },
    '598b8d3m': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // Meus_Orsamentos
  {
    'cd0zp71n': {
      'en': 'Meu orçamento',
      'ar': 'ميزانيتي',
      'de': 'Mein Budget',
      'es': 'Mi presupuesto',
    },
    'hfwbiivj': {
      'en': 'Renda',
      'ar': 'دخل',
      'de': 'Einkommen',
      'es': 'Ingreso',
    },
    'jjj3ydb1': {
      'en': '+R\$12,402',
      'ar': '+ 12402 دولار',
      'de': '+12.402 \$',
      'es': '+\$12,402',
    },
    'ns4vt604': {
      'en': '4.5% ',
      'ar': '4.5٪',
      'de': '4,5 %',
      'es': '4,5%',
    },
    'wcsc04wg': {
      'en': 'Gastos',
      'ar': 'الإنفاق',
      'de': 'Ausgaben',
      'es': 'Gasto',
    },
    'a5zzlh8f': {
      'en': '-R\$8,392',
      'ar': '- 8،392 دولارًا',
      'de': '-8.392 \$',
      'es': '-\$8,392',
    },
    '8xnbsdnb': {
      'en': '4.5% ',
      'ar': '4.5٪',
      'de': '4,5 %',
      'es': '4,5%',
    },
    '9il8u06k': {
      'en': 'Nome do Orçãmento',
      'ar': '',
      'de': '',
      'es': '',
    },
    'c81i1ybg': {
      'en': 'Total Gasto:',
      'ar': 'إجمال الصرف',
      'de': 'Gesamtausgaben',
      'es': 'Total gastado',
    },
    'ofz2zvlc': {
      'en': '•',
      'ar': '•',
      'de': '•',
      'es': '•',
    },
  },
  // Detalhes_Orcamentos
  {
    '9yi3zs3z': {
      'en': 'Nome do Orçamento',
      'ar': '',
      'de': '',
      'es': '',
    },
    '92alvg49': {
      'en': '\$25,000',
      'ar': '',
      'de': '',
      'es': '',
    },
    'p0gf1lfy': {
      'en': 'Por Mês',
      'ar': 'كل شهر',
      'de': 'Pro Monat',
      'es': 'Por mes',
    },
    'akubzhk3': {
      'en': '4 Days Left',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ti7ipegi': {
      'en': 'Total Gasto',
      'ar': 'إجمال الصرف',
      'de': 'Gesamtausgaben',
      'es': 'Total gastado',
    },
    'o7a8ijm4': {
      'en': '\$2,502',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ifi6fmsa': {
      'en': 'Transações',
      'ar': 'المعاملات',
      'de': 'Transaktionen',
      'es': 'Actas',
    },
    'h6hqhujt': {
      'en': 'Recompensas Vá Longe',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ak9m8szp': {
      'en': 'Renda',
      'ar': 'دخل',
      'de': 'Einkommen',
      'es': 'Ingreso',
    },
    '3doa1muw': {
      'en': '\$50.00',
      'ar': '',
      'de': '',
      'es': '',
    },
    'osq1v3c0': {
      'en': 'Hello World',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l53kroui': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // Tranferencia_Completa
  {
    'xf8d4sm8': {
      'en': 'Transferência concluída',
      'ar': 'نقل كامل',
      'de': 'Übertragung vollständig',
      'es': 'transferencia completa',
    },
    'iq9jjji8': {
      'en':
          'Ótimo trabalho, você transferiu fundos com sucesso. Pode levar alguns segundos para que os fundos saiam da sua conta.',
      'ar':
          'عمل رائع ، لقد قمت بتحويل الأموال بنجاح. قد يستغرق خروج الأموال من حسابك بضعة أيام.',
      'de':
          'Großartige Arbeit, Sie haben erfolgreich Geld überwiesen. Es kann einige Tage dauern, bis das Geld von Ihrem Konto abgebucht wird.',
      'es':
          'Buen trabajo, transfirió fondos con éxito. Los fondos pueden tardar unos días en salir de su cuenta.',
    },
    'wrbg19ed': {
      'en': 'Certo',
      'ar': 'تمام',
      'de': 'Okay',
      'es': 'Okey',
    },
    'ndkybnrt': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // Editar_Perfil
  {
    '4rzqov3y': {
      'en': 'Edite seu Perfil',
      'ar': 'تعديل الملف الشخصي',
      'de': 'Profil bearbeiten',
      'es': 'Editar perfil',
    },
    'zoxan2gi': {
      'en': 'Alterar foto',
      'ar': 'غير الصوره',
      'de': 'Foto ändern',
      'es': 'Cambiar foto',
    },
    '3p9y21e2': {
      'en': 'seu Nome',
      'ar': 'اسمك',
      'de': 'Dein Name',
      'es': 'Tu nombre',
    },
    'dw9gmjdc': {
      'en': 'Digite eu Nome...',
      'ar': 'من فضلك أدخل رقما صالحا...',
      'de': 'Bitte geben Sie eine gültige Nummer ein...',
      'es': 'Por favor ingrese un número valido...',
    },
    'z4fstn5l': {
      'en': 'seu Email',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'jozgvwyg': {
      'en': 'Digite seu Email...',
      'ar': 'بريدك الالكتروني',
      'de': 'Deine E-Mail',
      'es': 'Tu correo electrónico',
    },
    '8h1cjk5a': {
      'en': 'sua Idade',
      'ar': 'عمرك',
      'de': 'Ihr Alter',
      'es': 'Su edad',
    },
    'hqetkdla': {
      'en': 'Digite sua Idade...',
      'ar': '',
      'de': '',
      'es': '',
    },
    'i6edcl52': {
      'en': 'Salvar Alterações',
      'ar': 'حفظ التغييرات',
      'de': 'Änderungen speichern',
      'es': 'Guardar cambios',
    },
    '59naq8ur': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // Alterara_Senha
  {
    'l5iggwaz': {
      'en': 'Alterar Senha',
      'ar': 'تغيير كلمة المرور',
      'de': 'Kennwort ändern',
      'es': 'Cambia la contraseña',
    },
    'so3pjvmd': {
      'en':
          'Digite o e-mail associado à sua conta e enviaremos um link para redefinir sua senha.',
      'ar':
          'أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رابطًا لإعادة تعيين كلمة المرور الخاصة بك.',
      'de':
          'Geben Sie die mit Ihrem Konto verknüpfte E-Mail-Adresse ein und wir senden Ihnen einen Link zum Zurücksetzen Ihres Passworts.',
      'es':
          'Ingrese el correo electrónico asociado con su cuenta y le enviaremos un enlace para restablecer su contraseña.',
    },
    'ajy1c3r9': {
      'en': 'Seu Email',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'hsqfoxya': {
      'en': 'Digite seu Email...',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'if4pz6lm': {
      'en': 'Enviar link de redefinição',
      'ar': 'أرسل رابط إعادة التعيين',
      'de': 'Zurücksetzen-Link senden',
      'es': 'Enviar enlace de reinicio',
    },
    '5tvk9lv0': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // Configurar_Notificacoes
  {
    'sc4ff4ce': {
      'en': 'Notificações',
      'ar': 'إشعارات',
      'de': 'Benachrichtigungen',
      'es': 'Notificaciones',
    },
    'r72zvrv5': {
      'en':
          'Escolha abaixo quais notificações você deseja receber e atualizaremos as configurações.',
      'ar': 'اختر الإشعارات التي تريد تلقيها أدناه وسنقوم بتحديث الإعدادات.',
      'de':
          'Wählen Sie unten aus, welche Benachrichtigungen Sie erhalten möchten, und wir aktualisieren die Einstellungen.',
      'es':
          'Elija qué notificaciones desea recibir a continuación y actualizaremos la configuración.',
    },
    'gjygkr0n': {
      'en': 'Notificações Push',
      'ar': 'دفع الإخطارات',
      'de': 'Mitteilungen',
      'es': 'Notificaciones push',
    },
    '3y3yhxbk': {
      'en': 'Receba notificações push de nosso aplicativo regularmente.',
      'ar': 'تلقي إشعارات من تطبيقنا على أساس شبه منتظم.',
      'de':
          'Erhalten Sie regelmäßig Push-Benachrichtigungen von unserer Anwendung.',
      'es':
          'Reciba notificaciones Push de nuestra aplicación de forma semi regular.',
    },
    '1ytebj35': {
      'en': 'Notificações por E-mail',
      'ar': 'اشعارات البريد الالكتروني',
      'de': 'E-Mail Benachrichtigungen',
      'es': 'Notificaciónes de Correo Electrónico',
    },
    '9lvh5nst': {
      'en':
          'Receba notificações por e-mail de nossa equipe de marketing sobre novos recursos.',
      'ar':
          'تلقي إشعارات البريد الإلكتروني من فريق التسويق لدينا حول الميزات الجديدة.',
      'de':
          'Erhalten Sie E-Mail-Benachrichtigungen von unserem Marketingteam über neue Funktionen.',
      'es':
          'Reciba notificaciones por correo electrónico de nuestro equipo de marketing sobre nuevas funciones.',
    },
    '69d2j74u': {
      'en': 'Serviços de localização',
      'ar': 'خدمات الموقع',
      'de': 'Standortdienste',
      'es': 'Servicios de localización',
    },
    '3k8cuv0d': {
      'en':
          'Permita-nos rastrear sua localização, isso ajuda a controlar os gastos e mantém você seguro.',
      'ar':
          'اسمح لنا بتتبع موقعك ، فهذا يساعد على تتبع الإنفاق ويحافظ على سلامتك.',
      'de':
          'Erlauben Sie uns, Ihren Standort zu verfolgen, dies hilft, die Ausgaben im Auge zu behalten und schützt Sie.',
      'es':
          'Permítanos rastrear su ubicación, esto ayuda a realizar un seguimiento de los gastos y lo mantiene seguro.',
    },
    'isgrgbfs': {
      'en': 'Salvar Alterações',
      'ar': 'حفظ التغييرات',
      'de': 'Änderungen speichern',
      'es': 'Guardar cambios',
    },
    'a96mlyeh': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // Politica_Privacidade
  {
    'alczfiiy': {
      'en': 'política de Privacidade',
      'ar': 'سياسة الخصوصية',
      'de': 'Datenschutz-Bestimmungen',
      'es': 'Política de privacidad',
    },
    'fvsfg5on': {
      'en': 'Como usamos seus dados',
      'ar': 'كيف نستخدم بياناتك',
      'de': 'Wie wir Ihre Daten verwenden',
      'es': 'Cómo usamos sus datos',
    },
    'nbiyrnzl': {
      'en': '',
      'ar':
          'Lorem ipsum dolor sit amet، consectetur adipiscing elit، sed do eiusmod tempor incidunt ut labore et dolore magna aliqua. Accumsan sit amet nulla facilisi morbi tempus. غير consectetur a erat nam. دونك ألتريسيس تينسيدونت قوس غير مخادع. Velit sed ullamcorper morbi tincidunt. Molestie a iaculis في erat pellentesque adipiscing. موريس نونك كونيج سيرة ذاتية. Nisl tincidunt eget nullam non nisi. Faucibus nisl tincidunt eget nullam non nisi est. Leo duis ut diam quam nulla. Euismod lacinia في quis risus sed vulputate odio. فيليت كريمينسيم sodales ut eu sem سيرة ذاتية صحيحة justo eget. Risus feugiat في ما قبل ميتوس. Leo vel orci porta non pulvinar neque laoreet suspension interdum. Suscipit Tellus mauris a Diam Maecenas Sed enim ut sem. SEM السيرة الذاتية الصحيحة justo eget magna fermentum iaculis eu. لاسينيا في quis risus sed. Faucibus purus في ماسا مؤقت. ليو بقطر سوليتودين معرف مؤقت الاتحاد الأوروبي. Nisi scelerisque eu ultrices السيرة الذاتية موصل. Vulputate كريم معلق في وقت مبكر. Enim neque volutpat ac tincidunt vitae semper quis. Ipsum dolor sit amet consectetur adipiscing elit. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Sed sed risus Préium quam vulputate. Elit pellentesque موطن morbi tristique senectus et. Viverra maecenas accumsan lacus vel facilisis volutpat est. sit amet mattis vulputate enim nulla. Nisi lacus sed viverra Tellus في العادة السيئة. اجلس أميت ريسوس نولام إيجيت فيليس إيجيت نونك لوبورتيز. Pretium lectus quam id leo in vitae. Adipiscing Diam donec adipiscing tristique. كومودو سيد egestas egestas fringilla. Ipsum dolor sit amet consectetur adipiscing. Ipsum dolor sit amet consectetur adipiscing النخبة pellentesque المعيشية morbi. مونتيس ناسيتور ريديكولوس موس موريس. Ut etiam sit amet nisl purus in. Arcu ac Ornare suspendisse sed nisi lacus sed viverra.',
      'de':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Accumsan sit amet nulla facilisi morbi tempus. Non consectetur a erat nam. Donec ultrices tincidunt arcu non sodales. Velit sed ullamcorper morbi tincidunt. Molestie a iaculis bei erat pellentesque adipiscing. Mauris nunc congue nisi vitae. Nisl tincidunt eget nullam non nisi. Faucibus nisl tincidunt eget nullam non nisi est. Leo duis ut diam quam nulla. Euismod lacinia at quis risus sed vulputate odio. Velit dignissim sodales ut eu sem integer vitae justo eget. Risus feugiat in ante metus. Leo vel orci porta non pulvinar neque laoreet suspendisse interdum. Suscipit tellus mauris a diam maecenas sed enim ut sem. Sem integer vitae justo eget magna fermentum iaculis eu. Lacinia bei quis risus sed. Faucibus purus in massa tempor. Leo a diam sollicitudin tempor id eu. Nisi scelerisque eu ultrices vitae auctor. Vulputate dignissim suspendisse in est ante in. Enim neque volutpat ac tincidunt vitae semper quis. Ipsum dolor sit amet consectetur adipiscing elit. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Sed sed risus pretium quam vulputate. Elit pellentesque habitant morbi tristique senectus et. Viverra maecenas accumsan lacus vel facilisis volutpat est. Sit amet mattis vulputate enim nulla. Nisi lacus sed viverra tellus in hac habitasse. Sit amet risus nullam eget felis eget nunc lobortis. Pretium lectus quam id leo in vitae. Adipiscing diam donec adipiscing tristique. Commodo sed egestas egestas fringilla. Ipsum dolor sit amet consectetur adipiscing. Ipsum dolor sit amet consectetur adipiscing elit pellentesque habitant morbi. Montes nascetur ridiculus mus mauris. Ut etiam sit amet nisl purus in. Arcu ac tortor dignissim convallis aenean et tortor at. Ornare suspendisse sed nisi lacus sed viverra.',
      'es':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Accumsan sit amet nulla facilisi morbi tempus. Non consectetur a erat nam. Donec ultrices tincidunt arcu non sodales. Velit sed ullamcorper morbi tincidunt. Molestie a iaculis at erat pellentesque adipiscing. Mauris nunc congue nisi vitae. Nisl tincidunt eget nullam non nisi. Faucibus nisl tincidunt eget nullam non nisi est. Leo duis ut diam quam nulla. Euismod lacinia at quis risus sed vulputate odio. Velit dignissim sodales ut eu sem integer vitae justo eget. Risus feugiat in ante metus. Leo vel orci porta non pulvinar neque laoreet suspendisse interdum. Suscipit tellus mauris a diam maecenas sed enim ut sem. Sem entero vitae justo eget magna fermentum iaculis eu. Lacinia at quis risus sed. Faucibus purus en massa tempor. Leo a diam sollicitudin tempor id eu. Nisi scelerisque eu ultrices vitae auctor. Vulputate dignissim suspendisse in est ante in. Enim neque volutpat ac tincidunt vitae semper quis. Ipsum dolor sit amet consectetur adipiscing elit. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Sed sed risus pretium quam vulputate. Elit pellentesque habitant morbi tristique senectus et. Viverra maecenas accumsan lacus vel facilisis volutpat est. Sit amet mattis vulputate enim nulla. Nisi lacus sed viverra tellus in hac habitasse. Sit amet risus nullam eget felis eget nunc lobortis. Pretium lectus quam id leo in vitae. Adipiscing diam donec adipiscing tristique. Cómodo sed egestas egestas fringilla. Ipsum dolor sit amet consectetur adipiscing. Ipsum dolor sit amet consectetur adipiscing elit pellentesque habitant morbi. Montes nascetur ridiculus mus mauris. Ut etiam sit amet nisl purus in. Arcu ac tortor dignissim convallis aenean et tortor at. Ornare suspendisse sed nisi lacus sed viverra.',
    },
    'oks4x95o': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // tutorial_Perfil
  {
    '38wb3rix': {
      'en': 'Tutorial',
      'ar': 'درس تعليمي',
      'de': 'Lernprogramm',
      'es': 'Tutorial',
    },
    '3x7ve416': {
      'en': 'Crie seus próprios Orçamentos',
      'ar': 'إنشاء الميزانيات',
      'de': 'Erstellen Sie Budgets',
      'es': 'Crear presupuestos',
    },
    '292pbdw7': {
      'en':
          'Crie orçamentos nos quais você também pode vincular transações para facilitar o rastreamento.',
      'ar':
          'قم بإنشاء ميزانيات يمكنك ربط المعاملات بها أيضًا من أجل التتبع السهل.',
      'de':
          'Erstellen Sie Budgets, mit denen Sie auch Transaktionen verknüpfen können, um sie einfach nachverfolgen zu können.',
      'es':
          'Cree presupuestos en los que también pueda vincular transacciones para facilitar el seguimiento.',
    },
    'b10xvuf9': {
      'en': 'Acompanhe os seus Gastos',
      'ar': 'تتبع الإنفاق',
      'de': 'Behalten Sie die Ausgaben im Auge',
      'es': 'Mantenga un registro de los gastos',
    },
    't6k1smsm': {
      'en':
          'Adicione facilmente transações e associe-as aos orçamentos que foram criados.',
      'ar': 'أضف المعاملات بسهولة وربطها بالميزانيات التي تم إنشاؤها.',
      'de':
          'Fügen Sie ganz einfach Transaktionen hinzu und verknüpfen Sie sie mit erstellten Budgets.',
      'es':
          'Agregue fácilmente transacciones y asócielas con los presupuestos que se han creado.',
    },
    'u8xxj427': {
      'en': 'Análise Orçamentária',
      'ar': 'تحليل الميزانية',
      'de': 'Budgetanalyse',
      'es': 'Análisis de presupuesto',
    },
    'iqi0pkmb': {
      'en': 'Saiba onde estão seus orçamentos e como eles podem ser ajustados.',
      'ar': 'تعرف على مكان ميزانياتك وكيف يمكن تعديلها.',
      'de': 'Wissen, wo Ihre Budgets sind und wie sie angepasst werden können.',
      'es': 'Sepa dónde están sus presupuestos y cómo se pueden ajustar.',
    },
    'zotc7emz': {
      'en': 'Crie seu orçamento',
      'ar': '',
      'de': '',
      'es': '',
    },
    'uydm0fnm': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // homePage
  {
    'zca4c5r8': {
      'en': 'Bem-Vindo, ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'huglk0h9': {
      'en': 'Andrew',
      'ar': '',
      'de': '',
      'es': '',
    },
    'f3n8fq39': {
      'en': 'Welcome,',
      'ar': 'مرحبا،',
      'de': 'Herzlich willkommen,',
      'es': 'Bienvenidos,',
    },
    'ssx1aywl': {
      'en': 'Suas últimas atualizações estão abaixo.',
      'ar': 'آخر التحديثات الخاصة بك أدناه.',
      'de': 'Ihre neuesten Updates sind unten.',
      'es': 'Sus últimas actualizaciones se encuentran a continuación.',
    },
    'wknu2tm4': {
      'en': 'SALDO',
      'ar': 'الرصيد',
      'de': 'Gleichgewicht',
      'es': 'Equilibrio',
    },
    'syy689nt': {
      'en': 'R\$: 7,630',
      'ar': '7630 دولارًا',
      'de': '\$7.630',
      'es': '\$7,630',
    },
    'mtayv82b': {
      'en': '******',
      'ar': '7630 دولارًا',
      'de': '\$7.630',
      'es': '\$7,630',
    },
    'y7zomzzp': {
      'en': 'Serviço rápido',
      'ar': 'خدمة سريعة',
      'de': 'Schneller Service',
      'es': 'Servicio rapido',
    },
    'uq4zf3bl': {
      'en': 'Transferência',
      'ar': 'تحويل',
      'de': 'Transfer',
      'es': 'Transferir',
    },
    'xjyb24s6': {
      'en': 'Atividade',
      'ar': 'بطاقة وقفة',
      'de': 'Pausenkarte',
      'es': 'Tarjeta de pausa',
    },
    'dfjtbkbo': {
      'en': 'Transação',
      'ar': 'عملية',
      'de': 'Transaktion',
      'es': 'Transacción',
    },
    '24oplyo2': {
      'en': 'Nome da Trasição',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ftz91khf': {
      'en': 'Renda',
      'ar': 'دخل',
      'de': 'Einkommen',
      'es': 'Ingreso',
    },
    '9syy3pdd': {
      'en': '\$50.00',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ghp47fy5': {
      'en': 'Hello World',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9gxu361z': {
      'en': 'Orçamento',
      'ar': '',
      'de': '',
      'es': '',
    },
    'pm611iz1': {
      'en': 'Início',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jhgazpi3': {
      'en': 'Investimentos',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zmrv8xyq': {
      'en': '[User Name Here]',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jjftc35m': {
      'en': 'User.name@domainname.com',
      'ar': '',
      'de': '',
      'es': '',
    },
    'azdc0owl': {
      'en': 'Minha Conta',
      'ar': 'حسابي',
      'de': 'Mein Konto',
      'es': 'Mi cuenta',
    },
    '4vid2k6x': {
      'en': 'Editar Perfil',
      'ar': 'تعديل الملف الشخصي',
      'de': 'Profil bearbeiten',
      'es': 'Editar perfil',
    },
    'bhz94wkx': {
      'en': 'Alterar Senha',
      'ar': 'تغيير كلمة المرور',
      'de': 'Kennwort ändern',
      'es': 'Cambia la contraseña',
    },
    '7hy2sgle': {
      'en': 'Configurações \nde notificação',
      'ar': 'إعدادات الإشعار',
      'de': 'Benachrichtigungseinstellungen',
      'es': 'Configuración de las notificaciones',
    },
    'vf5k68ws': {
      'en': 'Tutorial',
      'ar': 'درس تعليمي',
      'de': 'Lernprogramm',
      'es': 'Tutorial',
    },
    't2xyzu55': {
      'en': 'Políticas de Privacidade',
      'ar': 'سياسة الخصوصية',
      'de': 'Datenschutz-Bestimmungen',
      'es': 'Política de privacidad',
    },
    'f3hxl69y': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // Investimentos
  {
    'hhb6veym': {
      'en': 'Saldo da Carteira',
      'ar': 'رصيد المحفظة',
      'de': 'Wallet-Guthaben',
      'es': 'Saldo de la cartera',
    },
    'fgf8icmv': {
      'en': '\$23,000',
      'ar': '23000 دولار',
      'de': '23.000 \$',
      'es': '\$23,000',
    },
    '2rrr446m': {
      'en': '3 moedas',
      'ar': '3 عملات',
      'de': '3 Währungen',
      'es': '3 monedas',
    },
    '8nac51xz': {
      'en': 'Trasnferência',
      'ar': 'تحويل',
      'de': 'Transfer',
      'es': 'Transferir',
    },
    's56t3xya': {
      'en': 'Atividade',
      'ar': 'نشاط',
      'de': 'Aktivität',
      'es': 'Actividad',
    },
    'vewa5op5': {
      'en': 'Bitcoin',
      'ar': 'بيتكوين',
      'de': 'Bitcoin',
      'es': 'Bitcoin',
    },
    '9oun2uok': {
      'en': '\$7,302',
      'ar': '7302 دولار',
      'de': '\$7.302',
      'es': '\$7,302',
    },
    'yla7uncg': {
      'en': '32% do portfólio',
      'ar': '32٪ من المحفظة',
      'de': '32 % des Portfolios',
      'es': '32% de la cartera',
    },
    '7hsm7t9z': {
      'en': ' ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'opob20j8': {
      'en': 'Solona',
      'ar': 'سولونا',
      'de': 'Solona',
      'es': 'Soloña',
    },
    'fi3cleyj': {
      'en': '\$7,302',
      'ar': '7302 دولار',
      'de': '\$7.302',
      'es': '\$7,302',
    },
    '606emxw1': {
      'en': '40% do portfólio',
      'ar': '40٪ من المحفظة',
      'de': '40 % des Portfolios',
      'es': '40% de la cartera',
    },
    'qx0ykpbm': {
      'en': ' ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l2io5lul': {
      'en': 'Dogecoin',
      'ar': 'دوجكوين',
      'de': 'Dogecoins',
      'es': 'dogecoin',
    },
    'krsyyttw': {
      'en': '\$7,302',
      'ar': '7302 دولار',
      'de': '\$7.302',
      'es': '\$7,302',
    },
    '4mvfe3pe': {
      'en': '57% do portfólio',
      'ar': '40٪ من المحفظة',
      'de': '40 % des Portfolios',
      'es': '40% de la cartera',
    },
    '6cm4jjje': {
      'en': ' ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'va72t944': {
      'en': '[User Name Here]',
      'ar': '',
      'de': '',
      'es': '',
    },
    'g92pmbes': {
      'en': 'User.name@domainname.com',
      'ar': '',
      'de': '',
      'es': '',
    },
    '87ckk25k': {
      'en': 'Minha Conta',
      'ar': 'حسابي',
      'de': 'Mein Konto',
      'es': 'Mi cuenta',
    },
    'tik33bl7': {
      'en': 'Editar Perfil',
      'ar': 'تعديل الملف الشخصي',
      'de': 'Profil bearbeiten',
      'es': 'Editar perfil',
    },
    'uxptclbg': {
      'en': 'Alterar Senha',
      'ar': 'تغيير كلمة المرور',
      'de': 'Kennwort ändern',
      'es': 'Cambia la contraseña',
    },
    '62f7vkki': {
      'en': 'Configurações \nde notificação',
      'ar': 'إعدادات الإشعار',
      'de': 'Benachrichtigungseinstellungen',
      'es': 'Configuración de las notificaciones',
    },
    'uwxexi3g': {
      'en': 'Tutorial',
      'ar': 'درس تعليمي',
      'de': 'Lernprogramm',
      'es': 'Tutorial',
    },
    '0cqxxacr': {
      'en': 'Políticas de Privacidade',
      'ar': 'سياسة الخصوصية',
      'de': 'Datenschutz-Bestimmungen',
      'es': 'Política de privacidad',
    },
    'vox9t1s0': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // budgetDetailsCopy
  {
    '6dfas8g4': {
      'en': 'Per Month',
      'ar': 'كل شهر',
      'de': 'Pro Monat',
      'es': 'Por mes',
    },
    'dy6w0ln9': {
      'en': 'Total Spent',
      'ar': 'إجمال الصرف',
      'de': 'Gesamtausgaben',
      'es': 'Total gastado',
    },
    '5d6rqkgu': {
      'en': 'Transactions',
      'ar': 'المعاملات',
      'de': 'Transaktionen',
      'es': 'Actas',
    },
    'njfhy68w': {
      'en': 'Income',
      'ar': 'دخل',
      'de': 'Einkommen',
      'es': 'Ingreso',
    },
    'nlvtc67b': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // Pausar_Cartao
  {
    'dt7m486y': {
      'en': 'Pausar Cartão',
      'ar': 'بطاقة وقفة',
      'de': 'Pausenkarte',
      'es': 'Tarjeta de pausa',
    },
    '6edae99k': {
      'en': 'Tem certeza de que deseja pausar seu cartão?',
      'ar': 'هل أنت متأكد أنك تريد إيقاف بطاقتك مؤقتًا؟',
      'de': 'Möchten Sie Ihre Karte wirklich pausieren?',
      'es': '¿Seguro que quieres pausar tu tarjeta?',
    },
    'omtrfcm5': {
      'en': 'Deixa para lá',
      'ar': 'لا بأس',
      'de': 'egal',
      'es': 'No importa',
    },
    'hw07mkb9': {
      'en': 'Sim, Pause',
      'ar': 'نعم توقف',
      'de': 'Ja, Pause',
      'es': 'Sí, pausa',
    },
  },
  // Criar_Transacao
  {
    '63in0ac5': {
      'en': 'Criar Transação',
      'ar': 'أضف معاملة',
      'de': 'Transaktion hinzufügen',
      'es': 'Agregar transacción',
    },
    '9dhu7n4t': {
      'en': 'Valor',
      'ar': 'مقدار',
      'de': 'Höhe',
      'es': 'Monto',
    },
    'hubvvbnf': {
      'en': 'Gasto em...',
      'ar': 'أنفقت في',
      'de': 'Verbracht bei',
      'es': 'gastado en',
    },
    '8yoddwsu': {
      'en': 'Office Budget',
      'ar': 'ميزانية المكتب',
      'de': 'Bürobudget',
      'es': 'Presupuesto de oficina',
    },
    '2i3o4p9d': {
      'en': 'External Transfer',
      'ar': 'التحويل الخارجي',
      'de': 'Externe Übertragung',
      'es': 'Transferencia externa',
    },
    '2re40omy': {
      'en': 'ACH Payment',
      'ar': 'دفع ACH',
      'de': 'ACH-Zahlung',
      'es': 'Pago CCA',
    },
    'q2ey55ok': {
      'en': 'Selecione Orçamento',
      'ar': 'حدد الميزانية',
      'de': 'Wählen Sie Budget aus',
      'es': 'Seleccionar presupuesto',
    },
    'wtmbc15n': {
      'en': 'Razão',
      'ar': 'سبب',
      'de': 'Grund',
      'es': 'Razón',
    },
    't54y79pd': {
      'en': 'Criar Transação',
      'ar': 'أضف معاملة',
      'de': 'Transaktion hinzufügen',
      'es': 'Agregar transacción',
    },
    'hj403wjq': {
      'en': 'Toque acima para concluir á sua solicitação',
      'ar': 'اضغط أعلاه لإكمال الطلب',
      'de': 'Tippen Sie oben, um die Anfrage abzuschließen',
      'es': 'Toque arriba para completar la solicitud',
    },
    'g0l6d4ny': {
      'en': 'Insira um valor',
      'ar': 'الرجاء إدخال مبلغ',
      'de': 'Bitte geben Sie einen Betrag ein',
      'es': 'Por favor ingrese una cantidad',
    },
    'c57jvrul': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2gepdugd': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    'd18730i4': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'yc7jmnst': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // Detalhe_Pagamento
  {
    'n3p8zz2v': {
      'en': 'Detalhes',
      'ar': 'تفاصيل',
      'de': 'Einzelheiten',
      'es': 'Detalles',
    },
    'dq25q9r7': {
      'en': 'Quantia',
      'ar': 'مقدار',
      'de': 'Höhe',
      'es': 'Monto',
    },
    '9xmn6758': {
      'en': 'R\$:',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rl59r1za': {
      'en': 'Fornecedor',
      'ar': 'بائع',
      'de': 'Verkäufer',
      'es': 'Vendedor',
    },
    '78icbpx8': {
      'en': 'Doctors Appointment',
      'ar': '',
      'de': '',
      'es': '',
    },
    '14ifirui': {
      'en': 'Quando',
      'ar': 'متى',
      'de': 'Wann',
      'es': 'Cuándo',
    },
    '5m98f935': {
      'en': 'Jul 26, 10:00am',
      'ar': '',
      'de': '',
      'es': '',
    },
    'iu4zx3rq': {
      'en': 'Razão:',
      'ar': 'سبب',
      'de': 'Grund',
      'es': 'Razón',
    },
    '064opxn8': {
      'en': 'Reason',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hkzdh69t': {
      'en': 'Gasto por',
      'ar': 'أنفقه',
      'de': 'Verbracht von',
      'es': 'gastado por',
    },
    'xztw36hf': {
      'en': '[display_name]',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rts8qb5v': {
      'en': 'user.name@domainname.com',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // Editar_Transacao
  {
    'fhl3iz8f': {
      'en': 'Editar Transação',
      'ar': 'تحرير المعاملة',
      'de': 'Transaktion bearbeiten',
      'es': 'Editar transacción',
    },
    't25o87xk': {
      'en': 'Valor',
      'ar': 'مقدار',
      'de': 'Höhe',
      'es': 'Monto',
    },
    'k4nxiuid': {
      'en': 'gasto em...',
      'ar': 'أنفقت في',
      'de': 'Verbracht bei',
      'es': 'gastado en',
    },
    'erq58w00': {
      'en': 'Office Budget',
      'ar': 'ميزانية المكتب',
      'de': 'Bürobudget',
      'es': 'Presupuesto de oficina',
    },
    '51hlz671': {
      'en': 'External Transfer',
      'ar': 'التحويل الخارجي',
      'de': 'Externe Übertragung',
      'es': 'Transferencia externa',
    },
    'cjvheccj': {
      'en': 'ACH Payment',
      'ar': 'دفع ACH',
      'de': 'ACH-Zahlung',
      'es': 'Pago CCA',
    },
    'cjgb0x7s': {
      'en': 'Selecione um Orçamento',
      'ar': 'حدد الميزانية',
      'de': 'Wählen Sie Budget aus',
      'es': 'Seleccionar presupuesto',
    },
    'li4i9vfq': {
      'en': 'Razão',
      'ar': 'سبب',
      'de': 'Grund',
      'es': 'Razón',
    },
    'x0wvij7f': {
      'en': 'Editar Transação',
      'ar': 'تحديث المعاملة',
      'de': 'Transaktion aktualisieren',
      'es': 'Actualizar transacción',
    },
    'irb2cvmf': {
      'en': 'Toque acima para salvar suas alterações.',
      'ar': 'اضغط أعلاه لحفظ التغييرات الخاصة بك.',
      'de': 'Tippen Sie oben, um Ihre Änderungen zu speichern.',
      'es': 'Toca arriba para guardar tus cambios.',
    },
    'i2p3q1lz': {
      'en': 'Please enter an amount',
      'ar': 'الرجاء إدخال مبلغ',
      'de': 'Bitte geben Sie einen Betrag ein',
      'es': 'Por favor ingrese una cantidad',
    },
  },
  // Transferir_Fundos
  {
    'fm1ka2q5': {
      'en': 'Transferir Fundos',
      'ar': 'تحويل الأموال',
      'de': 'Geld überweisen',
      'es': 'Transferir fondos',
    },
    'uabit0hh': {
      'en': 'Equilibrio',
      'ar': 'الرصيد',
      'de': 'Gleichgewicht',
      'es': 'Equilibrio',
    },
    'eto4ptn8': {
      'en': 'R\$: 7,630',
      'ar': '7630 دولارًا',
      'de': '\$7.630',
      'es': '\$7,630',
    },
    '9nkj1nxu': {
      'en': '**** 0149',
      'ar': '**** 0149',
      'de': '**** 0149',
      'es': '**** 0149',
    },
    'kwq1umyd': {
      'en': '05/25',
      'ar': '05/25',
      'de': '25.05',
      'es': '25/05',
    },
    '6fmvy471': {
      'en': 'Alterar Conta',
      'ar': 'تغير الحساب',
      'de': 'Account wechseln',
      'es': 'Cambiar cuenta',
    },
    'f5nwioi6': {
      'en': 'Transferência Interna',
      'ar': 'التحويل الداخلي',
      'de': 'Interner Transfer',
      'es': 'Transferencia interna',
    },
    'ne25d2pc': {
      'en': 'Transferência Externa',
      'ar': 'التحويل الخارجي',
      'de': 'Externe Übertragung',
      'es': 'Transferencia externa',
    },
    'wgtr48qh': {
      'en': 'Pagamento ACH',
      'ar': 'دفع ACH',
      'de': 'ACH-Zahlung',
      'es': 'Pago CCA',
    },
    '7g1lsfay': {
      'en': 'Tipo de transferência',
      'ar': '',
      'de': '',
      'es': '',
    },
    'k70i1kh0': {
      'en': 'Escolha uma conta',
      'ar': '',
      'de': '',
      'es': '',
    },
    'd7pv9h6g': {
      'en': ' Valor',
      'ar': 'المبلغ بالدولار',
      'de': '\$ Betrag',
      'es': '\$ Monto',
    },
    'cbkrxaej': {
      'en': 'O saldo da sua nova conta é:',
      'ar': 'رصيد حسابك الجديد هو:',
      'de': 'Ihr neuer Kontostand beträgt:',
      'es': 'El nuevo saldo de su cuenta es:',
    },
    '5zzpimvw': {
      'en': '\$7,630',
      'ar': '7630 دولارًا',
      'de': '\$7.630',
      'es': '\$7,630',
    },
    'dm2j72lx': {
      'en': 'Enviar transferência',
      'ar': 'أرسل حوالة',
      'de': 'Überweisung senden',
      'es': 'Enviar transferencia',
    },
    'majp75es': {
      'en': 'Toque acima para concluir a transferência',
      'ar': 'اضغط أعلاه لإكمال النقل',
      'de': 'Tippen Sie oben, um die Übertragung abzuschließen',
      'es': 'Toque arriba para completar la transferencia',
    },
  },
  // Criar_Oramento
  {
    '9qe8oh29': {
      'en': 'Criar Orçamento',
      'ar': 'إنشاء الميزانية',
      'de': 'Budget erstellen',
      'es': 'Crear presupuesto',
    },
    's0qdet4r': {
      'en': 'Valor',
      'ar': 'مقدار',
      'de': 'Höhe',
      'es': 'Monto',
    },
    'q2tj7bjl': {
      'en': 'Digite eu Orçamento',
      'ar': 'اسم الميزانية',
      'de': 'Budgetname',
      'es': 'Nombre del presupuesto',
    },
    '24jhydno': {
      'en': 'Descrição',
      'ar': 'وصف',
      'de': 'Beschreibung',
      'es': 'Descripción',
    },
    'wog8ez4k': {
      'en': 'Criar Orçamento',
      'ar': 'إنشاء الميزانية',
      'de': 'Budget erstellen',
      'es': 'Crear presupuesto',
    },
    'avhxvtpl': {
      'en': 'Toque acima para concluir a solicitação',
      'ar': 'اضغط أعلاه لإكمال الطلب',
      'de': 'Tippen Sie oben, um die Anfrage abzuschließen',
      'es': 'Toque arriba para completar la solicitud',
    },
    'ubr3hfn7': {
      'en': 'Please enter an amount',
      'ar': 'الرجاء إدخال مبلغ',
      'de': 'Bitte geben Sie einen Betrag ein',
      'es': 'Por favor ingrese una cantidad',
    },
  },
  // Deletar_Orcamento
  {
    'ugq6nz8j': {
      'en': 'Excluir Orçamento',
      'ar': 'حذف الميزانية',
      'de': 'Budget löschen',
      'es': 'Eliminar presupuesto',
    },
    'l8sz52dh': {
      'en':
          'Se você excluir este orçamento, suas transações não estarão mais associadas a ele.',
      'ar': 'إذا حذفت هذه الميزانية ، فلن تكون معاملاتك مرتبطة بها بعد الآن.',
      'de':
          'Wenn Sie dieses Budget löschen, sind Ihre Transaktionen nicht mehr damit verknüpft.',
      'es':
          'Si elimina este presupuesto, sus transacciones ya no estarán asociadas a él.',
    },
    '12cknuxn': {
      'en': 'Excluir Orçamento',
      'ar': 'حذف الميزانية',
      'de': 'Budget löschen',
      'es': 'Eliminar presupuesto',
    },
    'b2atatoh': {
      'en': 'Toque acima para excluir este Orçamento',
      'ar': 'انقر فوق لإزالة هذا bude',
      'de': 'Tippen Sie oben, um diese Bude zu entfernen',
      'es': 'Toque arriba para eliminar este bude',
    },
  },
  // Solicitar_Fundos
  {
    'ywd25ipo': {
      'en': 'Solicitar fundos',
      'ar': 'طلب التمويل',
      'de': 'Geld anfordern',
      'es': 'Pedír fondos',
    },
    'v1yzok0p': {
      'en': ' Valor',
      'ar': 'المبلغ بالدولار',
      'de': '\$ Betrag',
      'es': '\$ Monto',
    },
    '8dcrzcsy': {
      'en': 'Orçamento de escritório',
      'ar': 'ميزانية المكتب',
      'de': 'Bürobudget',
      'es': 'Presupuesto de oficina',
    },
    '72e3b1tv': {
      'en': 'Transferência Externa',
      'ar': 'التحويل الخارجي',
      'de': 'Externe Übertragung',
      'es': 'Transferencia externa',
    },
    'lg4x92ev': {
      'en': 'Pagamento ACH',
      'ar': 'دفع ACH',
      'de': 'ACH-Zahlung',
      'es': 'Pago CCA',
    },
    'linihcta': {
      'en': 'Selecioe Transferência',
      'ar': '',
      'de': '',
      'es': '',
    },
    'nzsolobm': {
      'en': 'razao',
      'ar': 'سبب',
      'de': 'Grund',
      'es': 'Razón',
    },
    'tnmwo4w1': {
      'en': 'Solicitar Fundos',
      'ar': 'طلب التمويل',
      'de': 'Geld anfordern',
      'es': 'Pedír fondos',
    },
    'z4f3r26o': {
      'en': 'Toque acima para concluir a solicitação',
      'ar': 'اضغط أعلاه لإكمال الطلب',
      'de': 'Tippen Sie oben, um die Anfrage abzuschließen',
      'es': 'Toque arriba para completar la solicitud',
    },
  },
  // Miscellaneous
  {
    'lzyb73wy': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kx9cdks4': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'efvtwj7k': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ec5hfa1e': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q5ljwvfo': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'j4rmwb3h': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6ah1b18f': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2kos1hen': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'aox3s4fb': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l8hv5a7z': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4pjwb70a': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0xlokf4y': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8twlwiwt': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    't4xzlq9q': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '513nj4m0': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'a1jxfgju': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
