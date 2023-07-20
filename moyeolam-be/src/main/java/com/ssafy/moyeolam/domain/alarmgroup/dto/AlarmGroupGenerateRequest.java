package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Size;
import java.time.LocalTime;
import java.util.List;

@Getter
@NoArgsConstructor
public class AlarmGroupGenerateRequest {
    @Size(min = 1, max = 50)
    private String title;

    @JsonFormat(pattern = "HH:mm")
    private LocalTime time;

    private List<String> dayOfWeek;

    private String alarmSound;

    private String alarmMission;
}
