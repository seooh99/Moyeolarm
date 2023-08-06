package com.ssafy.moyeolam.domain.auth.controller;

import com.ssafy.moyeolam.domain.auth.dto.LoginResponseDto;
import com.ssafy.moyeolam.domain.auth.dto.LoginRequestDto;
import com.ssafy.moyeolam.domain.auth.service.AuthService;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    public EnvelopeResponse<LoginResponseDto> login(LoginRequestDto loginRequestDto){

        String oauthIdentifier = loginRequestDto.getOauthIdentifier();

        return EnvelopeResponse.<LoginResponseDto>builder()
                .data(authService.login(oauthIdentifier))
                .build();
    }

    //    @GetMapping("/login/success")
//    public EnvelopeResponse<GetMemberDataResponseDto> getMemberData(@AuthenticationPrincipal PrincipalDetails principal){
//
//        Member member = principal.getMember();
//
//        return EnvelopeResponse.<GetMemberDataResponseDto>builder()
//                .data(authService.getMemberData(member))
//                .build();
//    }

}