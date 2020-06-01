abstract class StringValidator {
  bool isValid(String value);
}

class NonemptyStringValidators implements StringValidator{
  @override
  bool isValid(String value){
    return value.isEmpty;
  }
}

class EmailAndPasswordProviders {
  final StringValidator emailValidator = NonemptyStringValidators();
  final StringValidator passwordValidator = NonemptyStringValidators();
  final String emailerror = 'Email can\'t be empty';
  final String firstnameError = 'Firstname can\'t be empty';
  final String lastnameError = 'Lastname can\'t be empty';
  final String passwordError = 'Password can\'t be empty';
  final String ageError = 'Invalid Age';
  final String mobileError = 'Invalid MobileNo';
  final String addressError = 'Address can\'t be empty';
}