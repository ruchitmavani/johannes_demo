final userNameRegex = RegExp(r'^[A-Za-z\d@$!%*?&#\-_+=]+$');
final passwordCompleteRegex = RegExp(
  r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d@$!%*?&#\-_+=]+$',
);
final passwordCharacterRegex = RegExp(r'^[A-Za-z\d@$!%*?&#]+$');
final passwordNumberRegex = RegExp(r'^(?=.*[\d])[A-Za-z\d@$!%*?&#]+$');
final passwordCapitalRegex = RegExp(r'^(?=.*[A-Z])[A-Za-z\d@$!%*?&#]+$');
final passwordLowerRegex = RegExp(r'^(?=.*[a-z])[A-Za-z\d@$!%*?&#]+$');
final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
