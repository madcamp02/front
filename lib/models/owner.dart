import 'repository.dart';

class Owner {
  final String name;
  final List<Repository> repositories;

  Owner({required this.name, required this.repositories});
}
