package com.ssafy.moyeolam.domain.alarmgroup.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@NoArgsConstructor
public class RequestAlarmGroupRequestDto {
    private List<Long> memberIds;
}
