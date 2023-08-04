package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmDay;
import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.meta.domain.AlarmGroupMemberRole;
import com.ssafy.moyeolam.domain.meta.domain.DayOfWeek;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
public class AlarmGroupElement {
    private Long alarmGroupId;
    private String title;
//    private LocalTime time;
    private Integer hour;
    private Integer minute;
//    private List<String> dayOfWeek;
    private List<Boolean> dayOfWeek;
    private String alarmSound;
    private String alarmMission;
    private Boolean isLock;
    private Boolean isHost;
    private List<AlarmGroupMemberElement> members;

    public static AlarmGroupElement of(AlarmGroup alarmGroup, Member loginMember) {
        return AlarmGroupElement.builder()
                .alarmGroupId(alarmGroup.getId())
                .title(alarmGroup.getTitle())
                .hour(alarmGroup.getTime().getHour())
                .minute(alarmGroup.getTime().getMinute())
                .dayOfWeek(dayOfWeekToBoolean(alarmGroup.getAlarmDays()))
                .alarmSound(alarmGroup.getAlarmSound().getName())
                .alarmMission(alarmGroup.getAlarmMission().getName())
                .isLock(alarmGroup.getLock())
                .isHost(alarmGroup.getHostMember().getId().equals(loginMember.getId()))
                .members(alarmGroup.getAlarmGroupMembers().stream()
                        .map(AlarmGroupMemberElement::from)
                        .collect(Collectors.toList()))
                .build();
    }

    public static List<Boolean> dayOfWeekToBoolean(List<AlarmDay> alarmDays) {
        Boolean[] dayOfWeek = new Boolean[]{false, false, false, false, false, false, false};
        List<String> days = Arrays.stream(DayOfWeek.values())
                .map(DayOfWeek::getName)
                .collect(Collectors.toList());

        for (AlarmDay alarmDay : alarmDays) {
            dayOfWeek[days.indexOf(alarmDay.getDayOfWeek().getName())] = true;
        }
        return Arrays.asList(dayOfWeek);
    }
}
