import 'package:get_it/get_it.dart';
import 'package:quantbit_crm/contact_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}
