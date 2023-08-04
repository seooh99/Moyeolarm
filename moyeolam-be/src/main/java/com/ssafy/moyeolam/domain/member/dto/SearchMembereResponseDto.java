package com.ssafy.moyeolam.domain.member.dto;

import com.ssafy.moyeolam.domain.member.domain.Member;
import lombok.Builder;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
public class SearchMembereResponseDto {

    private final List<MemberElement> members;

    public static SearchMembereResponseDto of(List<Member> members){
        return SearchMembereResponseDto.builder()
                .members(members.stream()
                        .map(MemberElement::of)
                        .collect(Collectors.toList()))
                .build();
    }
}
