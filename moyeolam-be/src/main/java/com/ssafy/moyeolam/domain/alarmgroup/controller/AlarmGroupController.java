package com.ssafy.moyeolam.domain.alarmgroup.controller;

import com.ssafy.moyeolam.domain.alarmgroup.dto.SaveAlarmGroupRequestDto;
import com.ssafy.moyeolam.domain.alarmgroup.service.AlarmGroupService;
import com.ssafy.moyeolam.domain.member.dto.AuthenticatedMember;
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
    public EnvelopeResponse<Long> saveAlarmGroup(@RequestBody SaveAlarmGroupRequestDto requestDto) {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(1L)
                .build();

        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.saveAlarmGroup(requestDto, loginMember.getMemberId()))
                .build();
    }

    @GetMapping
    public EnvelopeResponse findAlarmGroups() {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(1L)
                .build();

        return EnvelopeResponse.builder()
                .data(alarmGroupService.findAlarmGroups(loginMember.getMemberId()))
                .build();
    }
}
