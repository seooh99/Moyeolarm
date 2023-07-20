package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import com.ssafy.moyeolam.domain.member.domain.Member;
import lombok.Builder;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
public class FindAlarmGroupsResponseDto {
    private List<FindAlarmGroupsElement> alarmGroups;

    public static FindAlarmGroupsResponseDto of(List<AlarmGroup> alarmGroups, Member loginMember) {
        return FindAlarmGroupsResponseDto.builder()
                .alarmGroups(alarmGroups.stream()
                        .map(alarmGroup -> FindAlarmGroupsElement.of(alarmGroup, loginMember))
                        .collect(Collectors.toList()))
                .build();
    }
}
