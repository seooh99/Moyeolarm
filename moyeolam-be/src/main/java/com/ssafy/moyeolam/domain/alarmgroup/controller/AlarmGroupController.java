package com.ssafy.moyeolam.domain.alarmgroup.controller;

import com.ssafy.moyeolam.domain.alarmgroup.dto.*;
import com.ssafy.moyeolam.domain.alarmgroup.service.AlarmGroupService;
import com.ssafy.moyeolam.domain.auth.dto.PrincipalDetails;
import com.ssafy.moyeolam.domain.member.dto.AuthenticatedMember;
import com.ssafy.moyeolam.domain.member.exception.MemberErrorInfo;
import com.ssafy.moyeolam.domain.member.exception.MemberException;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/alarmgroups")
@RequiredArgsConstructor
@Slf4j
public class AlarmGroupController {
    private final AlarmGroupService alarmGroupService;

    @PostMapping
    public EnvelopeResponse<Long> saveAlarmGroup(@RequestBody SaveAlarmGroupRequestDto requestDto, @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }
        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.saveAlarmGroup(requestDto, principalDetails.getMember().getId()))
                .build();
    }

    @GetMapping
    public EnvelopeResponse<FindAlarmGroupsResponseDto> findAlarmGroups(@AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<FindAlarmGroupsResponseDto>builder()
                .data(alarmGroupService.findAlarmGroups(principalDetails.getMember().getId()))
                .build();
    }

    @GetMapping("/{alarmGroupId}")
    public EnvelopeResponse<FindAlarmGroupResponseDto> findAlarmGroup(@PathVariable Long alarmGroupId, @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<FindAlarmGroupResponseDto>builder()
                .data(alarmGroupService.findAlarmGroup(alarmGroupId, principalDetails.getMember().getId()))
                .build();
    }

    @DeleteMapping("/{alarmGroupId}")
    public EnvelopeResponse<Long> quitAlarmGroup(@PathVariable Long alarmGroupId, @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.quitAlarmGroup(alarmGroupId, principalDetails.getMember().getId()))
                .build();
    }

    @PatchMapping("/{alarmGroupId}")
    public EnvelopeResponse<Long> updateAlarmGroup(@PathVariable Long alarmGroupId, @RequestBody UpdateAlarmGroupRequestDto requestDto,
                                                   @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.updateAlarmGroup(alarmGroupId, principalDetails.getMember().getId(), requestDto))
                .build();
    }


    @PostMapping("/{alarmGroupId}/request")
    public EnvelopeResponse<List<Long>> requestAlarmGroup(@PathVariable Long alarmGroupId, @RequestBody RequestAlarmGroupRequestDto requestDto,
                                                          @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<List<Long>>builder()
                .data(alarmGroupService.requestAlarmGroup(principalDetails.getMember().getId(), alarmGroupId, requestDto.getMemberIds()))
                .build();
    }

    @PostMapping("/{alarmGroupId}/approve")
    public EnvelopeResponse<Long> approveAlarmGroup(@PathVariable Long alarmGroupId, @RequestBody ApproveAlarmGroupRequestDto requestDto,
                                                    @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.approveAlarmGroup(alarmGroupId, principalDetails.getMember().getId(), requestDto.getFromMemberId(), requestDto.getToMemberId()))
                .build();
    }

    @PostMapping("/{alarmGroupId}/reject")
    public EnvelopeResponse<Long> rejectAlarmGroup(@PathVariable Long alarmGroupId, @RequestBody RejectAlarmGroupRequestDto requestDto,
                                                   @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }


        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.rejectAlarmGroup(alarmGroupId, principalDetails.getMember().getId(), requestDto.getFromMemberId(), requestDto.getToMemberId()))
                .build();
    }

    @PostMapping("/{alarmGroupId}/ban")
    public EnvelopeResponse<Long> banAlarmGroupMember(@PathVariable Long alarmGroupId, @RequestBody BanAlarmGroupMemberRequestDto banAlarmGroupMemberRequestDto,
                                                      @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<Long>builder()
                .data(alarmGroupService.banAlarmGroupMember(alarmGroupId, principalDetails.getMember().getId(), banAlarmGroupMemberRequestDto.getMemberId()))
                .build();
    }

    @PostMapping("/{alarmGroupId}/lock")
    public EnvelopeResponse<Boolean> lockAlarmGroup(@PathVariable Long alarmGroupId, @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<Boolean>builder()
                .data(alarmGroupService.lockAlarmGroup(alarmGroupId, principalDetails.getMember().getId()))
                .build();
    }

    @PostMapping("/{alarmGroupId}/toggle")
    public EnvelopeResponse<Boolean> toggleAlarm(@PathVariable Long alarmGroupId, @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<Boolean>builder()
                .data(alarmGroupService.toggleAlarm(alarmGroupId, principalDetails.getMember().getId()))
                .build();
    }

}
