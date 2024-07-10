class TIL {
  final int tilId;
  final int userId;
  final String tilContent;
  final int commitId;
  final String commitMsg;
  final DateTime commitDate;

  TIL({
    required this.tilId,
    required this.userId,
    required this.tilContent,
    required this.commitId,
    required this.commitMsg,
    required this.commitDate,
  });

  factory TIL.fromJson(Map<String, dynamic> json) {
    return TIL(
      tilId: json['til_id'],
      userId: json['user_id'],
      tilContent: json['til_content'],
      commitId: json['commit_id'],
      commitMsg: json['commit_msg'],
      commitDate: DateTime.parse(json['commit_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'til_id': tilId,
      'user_id': userId,
      'til_content': tilContent,
      'commit_id': commitId,
      'commit_msg': commitMsg,
      'commit_date': commitDate.toIso8601String(),
    };
  }
}
