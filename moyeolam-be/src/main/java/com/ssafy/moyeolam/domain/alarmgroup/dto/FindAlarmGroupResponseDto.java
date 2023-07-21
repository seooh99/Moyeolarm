package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import com.ssafy.moyeolam.domain.member.domain.Member;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class FindAlarmGroupResponseDto {
    private AlarmGroupElement alarmGroup;

    public static FindAlarmGroupResponseDto of(AlarmGroup alarmGroup, Member loginMember) {
        return FindAlarmGroupResponseDto.builder()
                .alarmGroup(AlarmGroupElement.of(alarmGroup, loginMember))
                .build();
    }
}
