package com.ssafy.moyeolam.domain.auth.service;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmGroupMemberRepository;
import com.ssafy.moyeolam.domain.auth.dto.GetMemberDataResponseDto;
import com.ssafy.moyeolam.domain.friend.domain.Friend;
import com.ssafy.moyeolam.domain.friend.repository.FriendRepository;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import com.ssafy.moyeolam.domain.member.repository.ProfileImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final AlarmGroupMemberRepository alarmGroupMemberRepository;
    private final FriendRepository friendRepository;
    private final ProfileImageRepository profileImageRepository;

    public GetMemberDataResponseDto getMemberData(Member member) {

        Long memberId = member.getId();
        List<AlarmGroupMember> alarmGroupMembers = alarmGroupMemberRepository.findAllWithAlarmGroupAndMemberByMemberId(memberId);
        List<Friend> friends = friendRepository.findAllByMemberId(memberId);

        Optional<ProfileImage> profileImageOptional = profileImageRepository.findByMember(member);

        ProfileImage profileImage = profileImageOptional.orElse(
                ProfileImage.builder().build()
        );

        return GetMemberDataResponseDto.of(member, profileImage, friends, alarmGroupMembers);
    }
}
