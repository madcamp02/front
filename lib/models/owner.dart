import 'repository.dart';

class Owner {
  final int ownerId;
  final bool isOrganization;
  final int ownerGithubId;
  final String ownerName;

  Owner({
    required this.ownerId,
    required this.isOrganization,
    required this.ownerGithubId,
    required this.ownerName,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      ownerId: json['owner_id'],
      isOrganization: json['is_organization'] == 1,
      ownerGithubId: json['owner_github_id'],
      ownerName: json['owner_name'],
    );
  }
}