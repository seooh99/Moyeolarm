package com.ssafy.moyeolam.domain.auth.service;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmGroupMemberRepository;
import com.ssafy.moyeolam.domain.auth.dto.LoginResponseDto;
import com.ssafy.moyeolam.domain.auth.exception.AuthErrorInfo;
import com.ssafy.moyeolam.domain.auth.exception.AuthException;
import com.ssafy.moyeolam.domain.auth.service.jwt.JwtProvider.JwtProvider;
import com.ssafy.moyeolam.domain.friend.domain.Friend;
import com.ssafy.moyeolam.domain.friend.repository.FriendRepository;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import com.ssafy.moyeolam.domain.member.exception.MemberErrorInfo;
import com.ssafy.moyeolam.domain.member.exception.MemberException;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import com.ssafy.moyeolam.domain.member.repository.ProfileImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final AlarmGroupMemberRepository alarmGroupMemberRepository;
    private final FriendRepository friendRepository;
    private final ProfileImageRepository profileImageRepository;
    private final MemberRepository memberRepository;
    private final JwtProvider jwtProvider;

//    public GetMemberDataResponseDto getMemberData(Member member) {
//
//        Long memberId = member.getId();
//        List<AlarmGroupMember> alarmGroupMembers = alarmGroupMemberRepository.findAllWithAlarmGroupAndMemberByMemberId(memberId);
//        List<Friend> friends = friendRepository.findAllByMemberId(memberId);
//
//        Optional<ProfileImage> profileImageOptional = profileImageRepository.findByMember(member);
//
//        ProfileImage profileImage = profileImageOptional.orElse(
//                ProfileImage.builder().build()
//        );
//
//        return GetMemberDataResponseDto.of(member, profileImage, friends, alarmGroupMembers);
//    }

    @Transactional
    public LoginResponseDto login(String oauthIdentifier){

        if(oauthIdentifier == null){
            throw new AuthException(AuthErrorInfo.NOT_FOUND_OAUTH_IDENTIFIER);
        }

        memberRepository.findByOauthIdentifier("kakao_"+oauthIdentifier)
                .ifPresentOrElse(
                        member -> {},
                        ()->{
                        Member member = Member.builder()
                                .oauthIdentifier("kakao_"+oauthIdentifier)
                                .build();
                        memberRepository.save(member);
                });

        Member member = memberRepository.findByOauthIdentifier("kakao_"+oauthIdentifier)
                .orElseThrow(()-> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        Long memberId = member.getId();
        List<AlarmGroupMember> alarmGroupMembers = alarmGroupMemberRepository.findAllWithAlarmGroupAndMemberByMemberId(memberId);
        List<Friend> friends = friendRepository.findAllByMemberId(memberId);

        Optional<ProfileImage> profileImageOptional = profileImageRepository.findByMember(member);

        ProfileImage profileImage = profileImageOptional.orElse(
                ProfileImage.builder().build()
        );

        String accessToken = jwtProvider.createAccessToken("kakao_"+oauthIdentifier);
        String refreshToken = jwtProvider.createRefreshToken();

        jwtProvider.updateRefreshToken(oauthIdentifier, refreshToken);

        return LoginResponseDto.of(member, profileImage, friends, alarmGroupMembers, accessToken, refreshToken);
    }
}