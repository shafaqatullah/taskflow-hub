import '../constants/app_constants.dart';
import '../errors/failures.dart';

abstract final class Validators {
  static String? validateTitle(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'Title is required.';
    }
    if (trimmed.length > AppConstants.maxTitleLength) {
      return 'Title must be at most ${AppConstants.maxTitleLength} characters.';
    }
    return null;
  }

  static String? validateDescription(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.length > AppConstants.maxDescriptionLength) {
      return 'Description must be at most ${AppConstants.maxDescriptionLength} characters.';
    }
    return null;
  }

  static void ensureValidTaskInput({
    required String title,
    required String description,
  }) {
    final titleError = validateTitle(title);
    if (titleError != null) {
      throw ValidationFailure(titleError);
    }

    final descriptionError = validateDescription(description);
    if (descriptionError != null) {
      throw ValidationFailure(descriptionError);
    }
  }
}
