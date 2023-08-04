package com.ssafy.moyeolam.domain.friend.exception;

import lombok.Getter;

@Getter
public enum FriendErrorInfo {
    ALREADY_REQUEST_STATUS("701", "이미 친구 요청중인 상태입니다."),
    ALREADY_APPROVE_STATUS("702", "이미 친구인 상태입니다."),
    NOT_FOUND_FRIEND_REQUEST("703", "존재하지 않는 친구 요청입니다."),
    NOT_REQUESTED_USER("704", "사용자에게 온 친구 요청이 아닙니다."),
    NOT_REQUEST_STATUS("705", "친구 요청 상태가 아닙니다."),
    NOT_FRIEND_STATUS("706", "친구 상태가 아닙니다.");

    private String code;
    private String message;

    FriendErrorInfo(String code, String message) {
        this.code = code;
        this.message = message;
    }
}
