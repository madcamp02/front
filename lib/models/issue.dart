class Issue {
  final int issueId;
  final String issueTitle;
  final int issueState;
  final int mlstnId;
  final List<int> labelIdList;
  final int ownerGithubId;
  final int repoGithubId;
  final int issueGithubId;

  Issue({
    required this.issueId,
    required this.issueTitle,
    required this.issueState,
    required this.mlstnId,
    required this.labelIdList,
    required this.ownerGithubId,
    required this.repoGithubId,
    required this.issueGithubId,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      issueId: json['issue_id'] is String ? int.parse(json['issue_id']) : json['issue_id'],
      issueTitle: json['issue_title'],
      issueState: json['issue_state'] is String ? int.parse(json['issue_state']) : json['issue_state'],
      mlstnId: json['mlstn_id'] is String ? int.parse(json['mlstn_id']) : json['mlstn_id'],
      labelIdList: (json['label_id_list'] as List<dynamic>).map((e) => e is String ? int.parse(e) : e as int).toList(),
      ownerGithubId: json['owner_github_id'] is String ? int.parse(json['owner_github_id']) : json['owner_github_id'],
      repoGithubId: json['repo_github_id'] is String ? int.parse(json['repo_github_id']) : json['repo_github_id'],
      issueGithubId: json['issue_github_id'] is String ? int.parse(json['issue_github_id']) : json['issue_github_id'],
    );
  }
}
