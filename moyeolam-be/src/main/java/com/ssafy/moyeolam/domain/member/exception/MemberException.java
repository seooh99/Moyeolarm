package com.ssafy.moyeolam.domain.member.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class MemberException extends RuntimeException{
    private final MemberErrorInfo info;

}
