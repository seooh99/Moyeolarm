package com.ssafy.moyeolam.domain.meta.domain;

public enum OauthType implements MetaDataProvider {
    KAKAO(1, "카카오");

    private final int id;
    private final String name;

    OauthType(int id, String name) {
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
