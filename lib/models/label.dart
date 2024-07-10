class Label {
  final int labelId;
  final String labelName;
  final String labelColor;
  final int ownerGithubId;
  final int repoGithubId;
  final int labelGithubId;

  Label({
    required this.labelId,
    required this.labelName,
    required this.labelColor,
    required this.ownerGithubId,
    required this.repoGithubId,
    required this.labelGithubId,
  });

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      labelId: json['label_id'] is String ? int.parse(json['label_id']) : json['label_id'],
      labelName: json['label_name'],
      labelColor: json['label_color'],
      ownerGithubId: json['owner_github_id'] is String ? int.parse(json['owner_github_id']) : json['owner_github_id'],
      repoGithubId: json['repo_github_id'] is String ? int.parse(json['repo_github_id']) : json['repo_github_id'],
      labelGithubId: json['label_github_id'] is String ? int.parse(json['label_github_id']) : json['label_github_id'],
    );
  }
}
