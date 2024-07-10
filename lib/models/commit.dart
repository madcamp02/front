class Commit {
  final int commitId;
  final int aiLabeled;
  final String commitMsg;
  final DateTime commitDate;
  final int? tilId;
  final List<dynamic> issueIdList;
  final int ownerGithubId;
  final int repoGithubId;
  final String commitGithubId;

  Commit({
    required this.commitId,
    required this.aiLabeled,
    required this.commitMsg,
    required this.commitDate,
    this.tilId,
    required this.issueIdList,
    required this.ownerGithubId,
    required this.repoGithubId,
    required this.commitGithubId,
  });

  factory Commit.fromJson(Map<String, dynamic> json) {
    return Commit(
      commitId: json['commit_id'] is String ? int.parse(json['commit_id']) : json['commit_id'],
      aiLabeled: json['ai_labeled'] is String ? int.parse(json['ai_labeled']) : json['ai_labeled'],
      commitMsg: json['commit_msg'],
      commitDate: DateTime.parse(json['commit_date']),
      tilId: json['til_id'] is String ? int.parse(json['til_id']) : json['til_id'],
      issueIdList: json['issue_id_list'] is String
          ? json['issue_id_list'].split(',').map((e) => e.trim()).toList()
          : List<dynamic>.from(json['issue_id_list']),
      ownerGithubId: json['owner_github_id'] is String ? int.parse(json['owner_github_id']) : json['owner_github_id'],
      repoGithubId: json['repo_github_id'] is String ? int.parse(json['repo_github_id']) : json['repo_github_id'],
      commitGithubId: json['commit_github_id'],
    );
  }
}
