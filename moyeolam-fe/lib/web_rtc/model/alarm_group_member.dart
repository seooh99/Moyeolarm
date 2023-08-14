
class AlarmGroupMember {
  final int memberId;
  final String nickname;
  MemberState memberState = MemberState.offline;
  String? SID;

  AlarmGroupMember({
    required this.memberId,
    required this.nickname,
  });
}

enum MemberState {
  offline("offline"),
  online("online"),
  recognized("recognized");

  const MemberState(this.code);
  final String code;
}
