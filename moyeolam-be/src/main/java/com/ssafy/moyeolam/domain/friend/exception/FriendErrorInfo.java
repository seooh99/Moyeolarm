package com.ssafy.moyeolam.domain.friend.exception;

import lombok.Getter;

@Getter
public enum FriendErrorInfo {
    ALREADY_REQUEST_STATUS("701", "이미 친구 요청중인 상태입니다."),
    ALREADY_APPROVE_STATUS("702", "이미 친구인 상태입니다.");

    private String code;
    private String message;

    FriendErrorInfo(String code, String message) {
        this.code = code;
        this.message = message;
    }
}
