package com.ssafy.moyeolam.domain.meta.domain;

public enum MatchStatus implements MetaDataProvider {
    REQUEST_STATUS(1, "요청상태"),
    APPROVE_STATUS(2, "수락상태"),
    REJECT_STATUS(3, "거절상태"),
    DELETE_STATUS(4, "삭제상태");

    private final int id;
    private final String name;

    MatchStatus(int id, String name) {
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
