package com.ssafy.moyeolam.domain.meta.domain;

public enum AlarmGroupMemberRole implements MetaDataProvider {
    HOST(1, "방장"),
    NORMAL(2, "일반 사용자");

    private final int id;
    private final String name;

    AlarmGroupMemberRole(int id, String name) {
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
