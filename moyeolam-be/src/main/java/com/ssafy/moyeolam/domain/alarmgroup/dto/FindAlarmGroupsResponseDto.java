package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import com.ssafy.moyeolam.domain.member.domain.Member;
import lombok.Builder;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
public class FindAlarmGroupsResponseDto {
    private List<AlarmGroupsElement> alarmGroups;

    public static FindAlarmGroupsResponseDto of(List<AlarmGroupMember> alarmGroupMembers, Member loginMember) {
        Long loginMemberId = loginMember.getId();
        return FindAlarmGroupsResponseDto.builder()
                .alarmGroups(alarmGroupMembers.stream()
                        .map(alarmGroupMember -> AlarmGroupsElement.of(alarmGroupMember, loginMemberId))
                        .collect(Collectors.toList()))
                .build();
    }
}
