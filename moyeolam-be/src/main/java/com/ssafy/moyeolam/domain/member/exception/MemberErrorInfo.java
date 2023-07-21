package com.ssafy.moyeolam.domain.member.exception;

import lombok.Getter;

@Getter
public enum MemberErrorInfo {
    NOT_FOUND_MEMBER("601","멤버를 찾을 수 없습니다.");


    private String code;
    private String message;

    MemberErrorInfo(String code, String message){
        this.code = code;
        this.message = message;
    }
}
