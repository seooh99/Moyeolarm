package com.ssafy.moyeolam.domain.member.exception;

import lombok.Getter;

@Getter
public enum MemberErrorInfo {
    NOT_FOUND_MEMBER("601","멤버를 찾을 수 없습니다."),
    NOT_FOUND_PROFILEIMAGE("602", "프로필 이미지를 찾을 수 없습니다."),
    NICKNAME_ALREADY_IN_USE("603", "이미 사용중인 닉네임 입니다."),
    NOT_FOUND_MEMBER_BY_NICKNAME("604", "해당 닉네임의 사용자를 찾을 수 없습니다."),
    SEARCH_MEMBER_MYSELF("605", "자기자신은 검색할 수 없습니다.");


    private String code;
    private String message;

    MemberErrorInfo(String code, String message){
        this.code = code;
        this.message = message;
    }
}
