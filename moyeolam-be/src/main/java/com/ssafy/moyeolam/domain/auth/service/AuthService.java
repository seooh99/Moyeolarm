package com.ssafy.moyeolam.domain.auth.service;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmGroupMemberRepository;
import com.ssafy.moyeolam.domain.auth.dto.LoginRequestDto;
import com.ssafy.moyeolam.domain.auth.dto.LoginResponseDto;
import com.ssafy.moyeolam.domain.auth.exception.AuthErrorInfo;
import com.ssafy.moyeolam.domain.auth.exception.AuthException;
import com.ssafy.moyeolam.domain.auth.service.jwt.JwtProvider.JwtProvider;
import com.ssafy.moyeolam.domain.friend.domain.Friend;
import com.ssafy.moyeolam.domain.friend.repository.FriendRepository;
import com.ssafy.moyeolam.domain.member.domain.FcmToken;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.domain.MemberToken;
import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import com.ssafy.moyeolam.domain.member.exception.MemberErrorInfo;
import com.ssafy.moyeolam.domain.member.exception.MemberException;
import com.ssafy.moyeolam.domain.member.repository.FcmTokenRepository;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import com.ssafy.moyeolam.domain.member.repository.MemberTokenRepository;
import com.ssafy.moyeolam.domain.member.repository.ProfileImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthService {
    private final ProfileImageRepository profileImageRepository;
    private final MemberRepository memberRepository;
    private final JwtProvider jwtProvider;
    private final MemberTokenRepository memberTokenRepository;
    private final FcmTokenRepository fcmTokenRepository;

    @Transactional
    public LoginResponseDto login(LoginRequestDto loginRequestDto) {
        String oauthIdentifier = loginRequestDto.getOauthIdentifier();
        String token = loginRequestDto.getFcmToken();
        String deviceIdentifier = loginRequestDto.getDeviceIdentifier();


        memberRepository.findByOauthIdentifier("kakao_" + oauthIdentifier)
                .ifPresentOrElse(
                        member -> {
                        },
                        () -> {
                            Member member = Member.builder()
                                    .oauthIdentifier("kakao_" + oauthIdentifier)
                                    .build();
                            memberRepository.save(member);
                        });

        Member member = memberRepository.findByOauthIdentifier("kakao_" + oauthIdentifier)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        Optional<ProfileImage> profileImageOptional = profileImageRepository.findByMember(member);

        ProfileImage profileImage = profileImageOptional.orElse(
                ProfileImage.builder().build()
        );

        String accessToken = jwtProvider.createAccessToken("kakao_" + oauthIdentifier);
        String refreshToken = jwtProvider.createRefreshToken();

        jwtProvider.updateRefreshToken(oauthIdentifier, refreshToken);

        memberTokenRepository.findByMember(member).ifPresentOrElse(
                memberToken -> {
                    memberToken.setRefreshToken(refreshToken);
                    memberToken.setAccessToken(accessToken);
                },
                () -> {
                    MemberToken newMemberToken = MemberToken.builder()
                            .acessToken(accessToken)
                            .refreshToken(refreshToken)
                            .member(member)
                            .build();
                    member.setMemberToken(newMemberToken);
                }
        );

        memberRepository.save(member);

        // fcm 토큰 정보 저장
        Boolean isFcmToken = fcmTokenRepository.existsByMemberIdAndFcmTokenAndDeviceIdentifier(member.getId(), token, deviceIdentifier);
        if (!isFcmToken) {
            FcmToken fcmToken = FcmToken.builder()
                    .member(member)
                    .fcmToken(token)
                    .deviceIdentifier(deviceIdentifier)
                    .build();
            fcmTokenRepository.save(fcmToken);
        }

        return LoginResponseDto.of(member, profileImage, accessToken, refreshToken);
    }
}