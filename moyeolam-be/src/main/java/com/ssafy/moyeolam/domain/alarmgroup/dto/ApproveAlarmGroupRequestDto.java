package com.ssafy.moyeolam.domain.alarmgroup.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ApproveAlarmGroupRequestDto {
    private Long fromMemberId;
    private Long toMemberId;

}
