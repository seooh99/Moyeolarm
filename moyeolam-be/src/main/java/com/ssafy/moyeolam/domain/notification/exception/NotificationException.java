package com.ssafy.moyeolam.domain.notification.exception;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class NotificationException extends RuntimeException{
    private final NotificationErrorInfo info;
}
