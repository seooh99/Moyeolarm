package com.ssafy.moyeolam.domain.alarmgroup.controller;

import com.ssafy.moyeolam.domain.alarmgroup.dto.*;
import com.ssafy.moyeolam.domain.alarmgroup.service.AlarmGroupService;
import com.ssafy.moyeolam.domain.member.dto.AuthenticatedMember;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/alarmgroups")
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
    public EnvelopeResponse<FindAlarmGroupsResponseDto> findAlarmGroups() {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(1L)
                .build();

        return EnvelopeResponse.<FindAlarmGroupsResponseDto>builder()
                .data(alarmGroupService.findAlarmGroups(loginMember.getMemberId()))
                .build();
    }

    @GetMapping("/{alarmGroupId}")
    public EnvelopeResponse<FindAlarmGroupResponseDto> findAlarmGroup(@PathVariable Long alarmGroupId) {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(1L)
                .build();

        return EnvelopeResponse.<FindAlarmGroupResponseDto>builder()
                .data(alarmGroupService.findAlarmGroup(alarmGroupId, loginMember.getMemberId()))
                .build();
    }

    @DeleteMapping("/{alarmGroupId}")
    public EnvelopeResponse<Long> quitAlarmGroup(@PathVariable Long alarmGroupId) {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(1L)
                .build();

        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.quitAlarmGroup(alarmGroupId, loginMember.getMemberId()))
                .build();
    }

    @PatchMapping("/{alarmGroupId}")
    public EnvelopeResponse<Long> updateAlarmGroup(@PathVariable Long alarmGroupId, @RequestBody UpdateAlarmGroupRequestDto requestDto) {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(1L)
                .build();

        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.updateAlarmGroup(alarmGroupId, loginMember.getMemberId(), requestDto))
                .build();
    }


    @PostMapping("/{alarmGroupId}/request")
    public EnvelopeResponse<List<Long>> requestAlarmGroup(@PathVariable Long alarmGroupId, @RequestBody RequestAlarmGroupRequestDto requestDto) {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(1L)
                .build();

        return EnvelopeResponse.<List<Long>>builder()
                .data(alarmGroupService.requestAlarmGroup(loginMember.getMemberId(), alarmGroupId, requestDto.getMemberIds()))
                .build();
    }

    @PostMapping("/{alarmGroupId}/approve")
    public EnvelopeResponse<Long> approveAlarmGroup(@PathVariable Long alarmGroupId, @RequestBody ApproveAlarmGroupRequestDto requestDto) {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(2L)
                .build();

        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.approveAlarmGroup(alarmGroupId, loginMember.getMemberId(), requestDto.getFromMemberId(), requestDto.getToMemberId()))
                .build();
    }

    @PostMapping("/{alarmGroupId}/reject")
    public EnvelopeResponse<Long> rejectAlarmGroup(@PathVariable Long alarmGroupId, @RequestBody RejectAlarmGroupRequestDto requestDto) {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(2L)
                .build();

        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.rejectAlarmGroup(alarmGroupId, loginMember.getMemberId(), requestDto.getFromMemberId(), requestDto.getToMemberId()))
                .build();
    }


}
