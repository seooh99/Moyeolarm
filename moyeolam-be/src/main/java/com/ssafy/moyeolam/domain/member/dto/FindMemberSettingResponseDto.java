package com.ssafy.moyeolam.domain.member.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class FindMemberSettingResponseDto {
    private final Boolean isNotificationToggle;

    public FindMemberSettingResponseDto(Boolean isNotificationToggle) {
        this.isNotificationToggle = isNotificationToggle;
    }
}
