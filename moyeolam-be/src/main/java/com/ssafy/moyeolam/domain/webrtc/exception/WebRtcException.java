package com.ssafy.moyeolam.domain.webrtc.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class WebRtcException extends RuntimeException {
    private WebRtcErrorInfo info;
}
