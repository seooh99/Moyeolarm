package com.ssafy.moyeolam.domain.alarmgroup.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import com.ssafy.moyeolam.domain.meta.domain.AlarmGroupMemberRole;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class AlarmGroupMemberElement {
    private Long memberId;
    private String nickname;
    private String profileImageUrl;
    private Boolean isHost;
    private Boolean toggle;

    public static AlarmGroupMemberElement from(AlarmGroupMember alarmGroupMember) {
        Member member = alarmGroupMember.getMember();
        ProfileImage profileImage = member.getProfileImage();

        return AlarmGroupMemberElement.builder()
                .memberId(alarmGroupMember.getId())
                .nickname(member.getNickname())
                .profileImageUrl(profileImage != null ? profileImage.getImageUrl() : null)
                .isHost(alarmGroupMember.getAlarmGroupMemberRole().getName().equals(AlarmGroupMemberRole.HOST.getName()))
                .toggle(alarmGroupMember.getAlarmToggle())
                .build();
    }
}
