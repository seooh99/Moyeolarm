package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class FindAlarmGroupResponseDto {
    private AlarmGroupElement alarmGroup;

    public static FindAlarmGroupResponseDto of(AlarmGroup alarmGroup, String role) {
        return FindAlarmGroupResponseDto.builder()
                .alarmGroup(AlarmGroupElement.of(alarmGroup, role))
                .build();
    }
}
