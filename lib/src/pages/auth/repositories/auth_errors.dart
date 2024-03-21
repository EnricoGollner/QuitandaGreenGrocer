String authErrorsString(String? errorCode) {
  switch (errorCode) {
    case 'INVALID_CREDENTIALS':
      return 'E-mail and/or password are incorrect';
    default:
      return 'Unknown error occurred';
  }
}
