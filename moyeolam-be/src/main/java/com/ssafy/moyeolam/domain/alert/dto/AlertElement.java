package com.ssafy.moyeolam.domain.alert.dto;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;
import java.time.LocalTime;

@Getter
@Builder
public class AlertElement {
    private String fromNickname;

    @JsonFormat(pattern = "HH:mm")
    private String title;

    private LocalTime time;
    private String alertType;
    private LocalDateTime createAt;
}
