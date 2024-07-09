class Repository {
  final int repoId;
  final String repoName;
  final String repoUrl;
  final int ownerGithubId;
  final int repoGithubId;

  Repository({
    required this.repoId,
    required this.repoName,
    required this.repoUrl,
    required this.ownerGithubId,
    required this.repoGithubId,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      repoId: json['repo_id'],
      repoName: json['repo_name'],
      repoUrl: json['repo_url'],
      ownerGithubId: json['owner_github_id'],
      repoGithubId: json['repo_github_id'],
    );
  }
}