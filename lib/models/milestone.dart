import 'issue.dart';

class Milestone {
  final String name;
  final List<Issue> issues;

  Milestone({required this.name, required this.issues});
}
