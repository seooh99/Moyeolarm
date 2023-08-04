package com.ssafy.moyeolam.domain.auth.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import com.ssafy.moyeolam.domain.alarmgroup.dto.AlarmGroupsElement;
import com.ssafy.moyeolam.domain.friend.domain.Friend;
import com.ssafy.moyeolam.domain.friend.dto.FriendElement;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import lombok.Builder;
import lombok.Getter;

import javax.annotation.Nullable;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Getter
@Builder
public class GetMemberDataResponseDto {

    private String nickname;
    private String profileImageUrl;
    private List<FriendElement> friends;
    private List<AlarmGroupsElement> alarmGroups;

    public static GetMemberDataResponseDto of(Member member, ProfileImage profileImage, List<Friend> friends, List<AlarmGroupMember> alarmGroupMembers){

        return GetMemberDataResponseDto.builder()
                .nickname(member.getNickname())
                .profileImageUrl(profileImage.getImageUrl())
                .friends(friends.stream()
                        .map(FriendElement::from)
                        .collect(Collectors.toList()))
                .alarmGroups(alarmGroupMembers.stream()
                        .map(AlarmGroupsElement::of)
                        .collect(Collectors.toList()))
                .build();
    }

}
