package com.ssafy.moyeolam.domain.alarmgroup.exception;

import lombok.Getter;

@Getter
public enum AlarmGroupErrorInfo {
    ERROR_MESSAGE("801","에러 메시지");


    private String code;
    private String message;

    AlarmGroupErrorInfo(String code, String message){
        this.code = code;
        this.message = message;
    }
}
