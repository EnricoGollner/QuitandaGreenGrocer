String authErrorsString(String? errorCode) {
  switch (errorCode) {
    case 'INVALID_CREDENTIALS':
      return 'E-mail and/or password are incorrect';
    case 'Invalid session token':
      return 'Invalid Token';
    default:
      return 'Unknown error occurred';
  }
}
