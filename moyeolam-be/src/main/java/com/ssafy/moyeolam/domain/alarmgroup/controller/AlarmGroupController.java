package com.ssafy.moyeolam.domain.alarmgroup.controller;

import com.ssafy.moyeolam.domain.alarmgroup.dto.AlarmGroupGenerateRequest;
import com.ssafy.moyeolam.domain.alarmgroup.service.AlarmGroupService;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/alarmgroup")
@RequiredArgsConstructor
@Slf4j
public class AlarmGroupController {
    private final AlarmGroupService alarmGroupService;

    @PostMapping
    public EnvelopeResponse<Long> generateAlarmGroup(@RequestBody AlarmGroupGenerateRequest request) {
        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.generateAlarmGroup(request))
                .build();
    }
}
