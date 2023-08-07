package com.ssafy.moyeolam.domain.auth.exception;

import lombok.Getter;

@Getter
public enum AuthErrorInfo {
    NOT_FOUND_OAUTH_IDENTIFIER("604", "oauthIdentifier가 없습니다.");

    private String code;
    private String message;

    AuthErrorInfo(String code, String message) {
        this.code = code;
        this.message = message;
    }
}
