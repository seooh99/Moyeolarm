package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalTime;
import java.util.List;

@Getter
@NoArgsConstructor
public class AlarmGroupGenerateRequest {
    @JsonFormat(pattern = "HH:mm")
    private LocalTime time;

    private List<String> dayOfWeek;

    private String alarmSound;

    private String alarmMission;
}
