



String? validateEmail(String? email) {
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (email==null) {
    return 'Email is required.';
  } else if (!emailRegex.hasMatch(email)) {
    return 'Enter a valid email.';
  }
  return null;
}

String? validatePassword(String? password) {
  if (password==null) {
    return 'Password is required.';
  } else if (password.length < 8) {
    return 'Password must be at least 8 characters long.';
  }
  return null;
}

String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (confirmPassword==null) {
    return 'Confirm password is required.';
  } else if (password != confirmPassword) {
    return 'Passwords do not match.';
  }
  return null;
}


String? validateUsernameNoSpaces(String? username) {
  if (username == null || username.isEmpty) {
    return 'Username is required.';
  }

  if (username.contains(' ')) {
    return 'Username cannot contain spaces.';
  }

  return null; // Username is valid (no spaces)
}

