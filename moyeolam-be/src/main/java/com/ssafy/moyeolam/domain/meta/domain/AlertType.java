package com.ssafy.moyeolam.domain.meta.domain;

public enum AlertType implements MetaDateProvider {
    FRIEND_APPROVE(1, "친구수락"),
    FRIEND_REJECT(2, "친구거절"),
    ALARM_GROUP_APPROVE(3, "알람그룹 수락"),
    ALARM_GROUP_REJECT(4, "알람그룹 거절"),
    ALARM_GROUP_QUIT(5, "알람그룹 탈퇴");

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
