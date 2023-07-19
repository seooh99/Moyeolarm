package com.ssafy.moyeolam.domain.meta.domain;

public enum AlarmMission implements MetaDateProvider {
    FACE_RECOGNITION(1, "얼굴 인식"),
    PRESS_BUTTON(2, "버튼 유지");

    private final int id;
    private final String name;

    AlarmMission(int id, String name) {
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
