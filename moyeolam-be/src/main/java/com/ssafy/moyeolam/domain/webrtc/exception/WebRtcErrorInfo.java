package com.ssafy.moyeolam.domain.webrtc.exception;

import lombok.Getter;

@Getter
public enum WebRtcErrorInfo {
    OPEN_VIDU_HTTP_EXCEPTION("901", "예상치 못한 HTTP 요청 상태입니다."),
    OPEN_VIDU_JAVA_CLIENT_EXCEPTION("902", "Java Client 내부 오류입니다.");

    private String code;
    private String message;

    WebRtcErrorInfo(String code, String message) {
        this.code = code;
        this.message = message;
    }
}
