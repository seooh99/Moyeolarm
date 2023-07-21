package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import lombok.Builder;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
public class FindAlarmGroupsResponseDto {
    private List<AlarmGroupsElement> alarmGroups;

    public static FindAlarmGroupsResponseDto of(List<AlarmGroupMember> alarmGroupMembers) {
        return FindAlarmGroupsResponseDto.builder()
                .alarmGroups(alarmGroupMembers.stream()
                        .map(AlarmGroupsElement::of)
                        .collect(Collectors.toList()))
                .build();
    }
}
