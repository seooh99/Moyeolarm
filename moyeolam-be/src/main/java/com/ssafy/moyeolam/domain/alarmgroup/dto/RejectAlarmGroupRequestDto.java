package com.ssafy.moyeolam.domain.alarmgroup.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class RejectAlarmGroupRequestDto {
    private Long fromMemberId;
    private Long toMemberId;
}
