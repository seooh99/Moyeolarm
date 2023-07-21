package com.ssafy.moyeolam.domain.friend.exception;

import lombok.Getter;

@Getter
public enum FriendErrorInfo {
    ALREADY_REQUEST_STATUS("701", "Already Request Status"),
    ALREADY_APPROVE_STATUS("702", "Already Approve Status");

    private String code;
    private String message;

    FriendErrorInfo(String code, String message) {
        this.code = code;
        this.message = message;
    }
}
