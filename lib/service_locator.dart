import 'package:get_it/get_it.dart';
import 'package:quantbit_crm/email.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}
