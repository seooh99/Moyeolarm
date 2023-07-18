package com.ssafy.moyeolam.domain.meta.domain;

public enum AlarmSound implements MetaDateProvider {
    BASE_SOUND(1, "기본 알림음");

    private final int id;
    private final String name;

    AlarmSound(int id, String name) {
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
