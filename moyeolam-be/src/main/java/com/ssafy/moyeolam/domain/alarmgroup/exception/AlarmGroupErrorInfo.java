package com.ssafy.moyeolam.domain.alarmgroup.exception;

import lombok.Getter;

@Getter
public enum AlarmGroupErrorInfo {
    ALREADY_NOT_ALARM_GROUP_MEMBER("801", "이미 알람그룹 멤버가 아닙니다."),
    NOT_FOUND_ALARM_GROUP("802", "존재하지 않는 알람그룹입니다."),
    UNAUTHORIZED_UPDATE("803", "알람그룹 수정 권한이 없습니다."),
    UNAUTHORIZED_REQUEST("804", "알람그룹 초대 권한이 없습니다."),
    NOT_FOUND_ALARM_GROUP_REQUEST("805", "알람 그룹 요청이 없습니다."),
    UNAUTHORIZED_APPROVE("806", "알람그룹 수락 권한이 없습니다."),
    UNAUTHORIZED_BAN("807", "알람그룹 강퇴 권한이 없습니다."),
    NOT_SELF_BAN("808", "자신은 강퇴할 수 없습니다."),
    NOT_FOUND_ALARM_GROUP_MEMBER("809", "알람그룹 멤버를 찾을 수 없습니다."),
    UNAUTHORIZED_LOCK("810", "알람그룹 잠금 권한이 없습니다.");


    private String code;
    private String message;

    AlarmGroupErrorInfo(String code, String message) {
        this.code = code;
        this.message = message;
    }
}
