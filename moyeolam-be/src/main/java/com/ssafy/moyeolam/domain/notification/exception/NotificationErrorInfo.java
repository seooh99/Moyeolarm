package com.ssafy.moyeolam.domain.notification.exception;

import lombok.Getter;

@Getter
public enum NotificationErrorInfo {
    NOTIFICATION_SEND_ERROR("1001", "푸시알람 전송에 실패했습니다.");


    private String code;
    private String message;

    NotificationErrorInfo(String code, String message) {
        this.code = code;
        this.message = message;
    }
}
