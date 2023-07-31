package com.ssafy.moyeolam.domain.alert.controller;


import com.ssafy.moyeolam.domain.alert.dto.FindAlertsResponseDto;
import com.ssafy.moyeolam.domain.alert.service.AlertService;
import com.ssafy.moyeolam.domain.member.dto.AuthenticatedMember;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
    public EnvelopeResponse<FindAlertsResponseDto> findAlerts() {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(2L)
                .build();

        return EnvelopeResponse.<FindAlertsResponseDto>builder()
                .data(alertService.findAlerts(loginMember.getMemberId()))
                .build();
    }
}
