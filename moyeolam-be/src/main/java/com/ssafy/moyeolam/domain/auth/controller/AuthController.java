package com.ssafy.moyeolam.domain.auth.controller;

import com.ssafy.moyeolam.domain.auth.dto.GetMemberDataResponseDto;
import com.ssafy.moyeolam.domain.auth.dto.PrincipalDetails;
import com.ssafy.moyeolam.domain.auth.service.AuthService;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @GetMapping("/login/success")
    public EnvelopeResponse<GetMemberDataResponseDto> getMemberData(@AuthenticationPrincipal PrincipalDetails principal){

        Member member = principal.getMember();

        return EnvelopeResponse.<GetMemberDataResponseDto>builder()
                .data(authService.getMemberData(member))
                .build();
    }
}
