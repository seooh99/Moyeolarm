package com.ssafy.moyeolam.domain.alert.controller;


import com.ssafy.moyeolam.domain.alert.dto.FindAlertsResponseDto;
import com.ssafy.moyeolam.domain.alert.service.AlertService;
import com.ssafy.moyeolam.domain.auth.dto.PrincipalDetails;
import com.ssafy.moyeolam.domain.member.dto.AuthenticatedMember;
import com.ssafy.moyeolam.domain.member.exception.MemberErrorInfo;
import com.ssafy.moyeolam.domain.member.exception.MemberException;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("alerts")
@Slf4j
public class AlertController {

    private final AlertService alertService;

    @GetMapping
    public EnvelopeResponse<FindAlertsResponseDto> findAlerts(@AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<FindAlertsResponseDto>builder()
                .data(alertService.findAlerts(principalDetails.getMember().getId()))
                .build();
    }
}
