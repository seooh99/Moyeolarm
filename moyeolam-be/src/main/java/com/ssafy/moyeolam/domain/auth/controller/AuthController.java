package com.ssafy.moyeolam.domain.auth.controller;

import com.ssafy.moyeolam.domain.auth.dto.LoginResponseDto;
import com.ssafy.moyeolam.domain.auth.dto.LoginRequestDto;
import com.ssafy.moyeolam.domain.auth.service.AuthService;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    public EnvelopeResponse<LoginResponseDto> login(@Valid @RequestBody LoginRequestDto loginRequestDto) {

        return EnvelopeResponse.<LoginResponseDto>builder()
                .data(authService.login(loginRequestDto))
                .build();
    }

}