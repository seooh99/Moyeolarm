package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import com.ssafy.moyeolam.domain.member.domain.Member;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalTime;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
public class FindAlarmGroupsElement {
    private Long alarmGroupId;
    private String title;
    private LocalTime time;
    private List<String> dayOfWeek;
    private Boolean toggle;

    public static FindAlarmGroupsElement of(AlarmGroup alarmGroup, Member loginMember) {
        return FindAlarmGroupsElement.builder()
                .alarmGroupId(alarmGroup.getId())
                .title(alarmGroup.getTitle())
                .time(alarmGroup.getTime())
                .dayOfWeek(alarmGroup.getAlarmDays()
                        .stream()
                        .map(day -> day.getDayOfWeek().getName())
                        .collect(Collectors.toList()))
                .toggle(getToggle(alarmGroup, loginMember))
                .build();
    }

    private static Boolean getToggle(AlarmGroup alarmGroup, Member loginMember) {
        List<AlarmGroupMember> alarmGroupMembers = alarmGroup.getAlarmGroupMembers();
        Long loginMemberId = loginMember.getId();

        for (AlarmGroupMember alarmGroupMember : alarmGroupMembers) {
            if (alarmGroupMember.getId().equals(loginMemberId)) {
                return alarmGroupMember.getAlarmToggle();
            }
        }
        return false;
    }
}
