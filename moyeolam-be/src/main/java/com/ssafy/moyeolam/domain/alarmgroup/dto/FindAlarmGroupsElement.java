package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
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

    public static FindAlarmGroupsElement of(AlarmGroupMember alarmGroupMember) {
        AlarmGroup alarmGroup = alarmGroupMember.getAlarmGroup();

        return FindAlarmGroupsElement.builder()
                .alarmGroupId(alarmGroup.getId())
                .title(alarmGroup.getTitle())
                .time(alarmGroup.getTime())
                .dayOfWeek(alarmGroup.getAlarmDays()
                        .stream()
                        .map(day -> day.getDayOfWeek().getName())
                        .collect(Collectors.toList()))
                .toggle(alarmGroupMember.getAlarmToggle())
                .build();
    }
}
