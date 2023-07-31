package com.ssafy.moyeolam.domain.webrtc.controller;

import com.ssafy.moyeolam.domain.webrtc.dto.GetTokenRequestDto;
import com.ssafy.moyeolam.domain.webrtc.service.WebRtcService;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/webrtc")
@RequiredArgsConstructor
@Slf4j
public class WebRtcController {
    private final WebRtcService webRtcService;

    @PostMapping("/get-token")
    public EnvelopeResponse<String> getToken(@RequestBody GetTokenRequestDto requestDto) {
        return EnvelopeResponse.<String>builder()
                .data(webRtcService.getToken(requestDto))
                .build();
    }
}
