package com.ssafy.moyeolam.domain.alarmgroup.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class AlarmGroupException extends RuntimeException {
    private final AlarmGroupErrorInfo info;
}
