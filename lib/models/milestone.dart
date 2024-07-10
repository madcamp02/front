import 'issue.dart';

class Milestone {
  final int mlstnId;
  final int mlstnState;
  final String mlstnTitle;
  final DateTime? mlstnDue;
  final String mlstnDescr;
  final int ownerGithubId;
  final int repoGithubId;
  final int mlstnGithubId;

  Milestone({
    required this.mlstnId,
    required this.mlstnState,
    required this.mlstnTitle,
    required this.mlstnDue,
    required this.mlstnDescr,
    required this.ownerGithubId,
    required this.repoGithubId,
    required this.mlstnGithubId,
  });

  factory Milestone.fromJson(Map<String, dynamic> json) {
    return Milestone(
      mlstnId: json['mlstn_id'] is String ? int.parse(json['mlstn_id']) : json['mlstn_id'],
      mlstnState: json['mlstn_state'] is String ? int.parse(json['mlstn_state']) : json['mlstn_state'],
      mlstnTitle: json['mlstn_title'],
      mlstnDue: json['mlstn_due'] != null ? DateTime.parse(json['mlstn_due']) : null,
      mlstnDescr: json['mlstn_descr'],
      ownerGithubId: json['owner_github_id'] is String ? int.parse(json['owner_github_id']) : json['owner_github_id'],
      repoGithubId: json['repo_github_id'] is String ? int.parse(json['repo_github_id']) : json['repo_github_id'],
      mlstnGithubId: json['mlstn_github_id'] is String ? int.parse(json['mlstn_github_id']) : json['mlstn_github_id'],
    );
  }
}
