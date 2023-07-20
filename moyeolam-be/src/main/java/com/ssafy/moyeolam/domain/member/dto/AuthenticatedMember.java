package com.ssafy.moyeolam.domain.member.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class AuthenticatedMember {
    private Long memberId;
}
