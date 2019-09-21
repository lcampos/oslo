// NOTE: Update this query if you modify the config/users/... files
try {
  List<User> lusers = [Select Id, LastName from User where LastName = 'Auditor' or LastName = 'Manager'];

  for (User usr : lusers) {
    System.resetPassword(usr.Id, true);
    System.debug('user id' + usr.Id);
  }    
} catch (Exception e) {
    System.debug('Exception during password reset');
    System.debug(logginglevel.INFO, '--- Message : ' + e.getMessage());
    System.debug(logginglevel.INFO, '--- Cause : ' + e.getCause());
    System.debug(logginglevel.INFO, '--- Type : ' + e.getTypeName());
}
