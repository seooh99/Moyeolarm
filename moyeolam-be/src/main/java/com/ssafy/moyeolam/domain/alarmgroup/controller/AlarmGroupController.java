package com.ssafy.moyeolam.domain.alarmgroup.controller;

import com.ssafy.moyeolam.domain.alarmgroup.dto.SaveAlarmGroupRequestDto;
import com.ssafy.moyeolam.domain.alarmgroup.service.AlarmGroupService;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/alarmgroup")
@RequiredArgsConstructor
@Slf4j
public class AlarmGroupController {
    private final AlarmGroupService alarmGroupService;

    @PostMapping
    public EnvelopeResponse<Long> generateAlarmGroup(@RequestBody SaveAlarmGroupRequestDto requestDto) {
        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.generateAlarmGroup(requestDto))
                .build();
    }

    @GetMapping
    public EnvelopeResponse findAlarmGroups(){

        return EnvelopeResponse.builder()
                .data(null)
                .build();
    }
}
