package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmDay;
import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.meta.domain.DayOfWeek;
import com.ssafy.moyeolam.domain.meta.domain.MetaData;
import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
public class AlarmGroupsElement {
    private Long alarmGroupId;
    private String title;
    private Integer hour;
    private Integer minute;
    //    private List<String> dayOfWeek;
    private List<Boolean> dayOfWeek;
    private Boolean isLock;
    private Boolean toggle;
    private Boolean isHost;

    public static AlarmGroupsElement of(AlarmGroupMember alarmGroupMember, Long loginMemberId) {
        AlarmGroup alarmGroup = alarmGroupMember.getAlarmGroup();

        return AlarmGroupsElement.builder()
                .alarmGroupId(alarmGroup.getId())
                .title(alarmGroup.getTitle())
                .hour(alarmGroup.getTime().getHour())
                .minute(alarmGroup.getTime().getMinute())
                .dayOfWeek(dayOfWeekToBoolean(alarmGroup.getAlarmDays()))
                .isLock(alarmGroup.getLock())
                .toggle(alarmGroupMember.getAlarmToggle())
                .isHost(alarmGroup.getHostMember().getId().equals(loginMemberId))
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
