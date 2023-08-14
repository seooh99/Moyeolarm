package com.ssafy.moyeolam.domain.meta.domain;

public enum AlertType implements MetaDataProvider {
    FRIEND_APPROVE(1, "친구 수락"),
    FRIEND_REQUEST(2, "친구 요청"),
    ALARM_GROUP_APPROVE(3, "알람그룹 수락"),
    ALARM_GROUP_QUIT(4, "알람그룹 탈퇴"),
    ALARM_GROUP_BAN(5, "알람그룹 강퇴"),
    ALARM_GROUP_REQUEST(6,"알람그룹 요청"),
    ALARM_GROUP_UPDATE(7, "알람그룹 수정"),
    ALARM_GROUP_ABOLISHED(8, "알람그룹 해체");

    private final int id;
    private final String name;

    AlertType(int id, String name) {
        this.id = id;
        this.name = name;
    }

    @Override
    public int getId() {
        return this.id;
    }

    @Override
    public String getName() {
        return this.name;
    }
}
