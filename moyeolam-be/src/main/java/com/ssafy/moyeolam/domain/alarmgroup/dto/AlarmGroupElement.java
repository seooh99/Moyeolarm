package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.meta.domain.AlarmGroupMemberRole;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalTime;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
public class AlarmGroupElement {
    private Long alarmGroupId;
    private String title;
    private LocalTime time;
    private List<String> dayOfWeek;
    private String alarmSound;
    private String alarmMission;
    private Boolean isLock;
    private Boolean isHost;
    private List<AlarmGroupMemberElement> members;

    public static AlarmGroupElement of(AlarmGroup alarmGroup, Member loginMember) {
        return AlarmGroupElement.builder()
                .alarmGroupId(alarmGroup.getId())
                .title(alarmGroup.getTitle())
                .time(alarmGroup.getTime())
                .dayOfWeek(alarmGroup.getAlarmDays()
                        .stream()
                        .map(day -> day.getDayOfWeek().getName())
                        .collect(Collectors.toList()))
                .alarmSound(alarmGroup.getAlarmSound().getName())
                .alarmMission(alarmGroup.getAlarmMission().getName())
                .isLock(alarmGroup.getLock())
                .isHost(alarmGroup.getHostMember().getId().equals(loginMember.getId()))
                .members(alarmGroup.getAlarmGroupMembers().stream()
                        .map(AlarmGroupMemberElement::from)
                        .collect(Collectors.toList()))
                .build();
    }
}
