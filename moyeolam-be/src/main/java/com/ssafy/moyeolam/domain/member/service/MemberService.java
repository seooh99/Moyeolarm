package com.ssafy.moyeolam.domain.member.service;

import com.ssafy.moyeolam.domain.friend.domain.FriendRequest;
import com.ssafy.moyeolam.domain.friend.repository.FriendRepository;
import com.ssafy.moyeolam.domain.friend.repository.FriendRequestRepository;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import com.ssafy.moyeolam.domain.member.dto.*;
import com.ssafy.moyeolam.domain.member.exception.MemberErrorInfo;
import com.ssafy.moyeolam.domain.member.exception.MemberException;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import com.ssafy.moyeolam.domain.member.repository.ProfileImageRepository;
import com.ssafy.moyeolam.infra.storage.service.S3Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberService {
    private final MemberRepository memberRepository;
    private final ProfileImageRepository profileImageRepository;
    private final FriendRepository friendRepository;
    private final S3Service s3Service;


    @Transactional
    public UploadProfileImageResponseDto uploadProfileImage(Member member, UploadProfileImageRequestDto uploadProfileImageRequestDto) throws IOException {

        profileImageRepository.findByMember(member)
                .ifPresent(profileImage -> {
                            this.deleteProfileImage(member);
                        }
                );

        String dirName = "profile_image";
        Map<String, String> result = s3Service.uploadFile(uploadProfileImageRequestDto.getFile(), dirName);

        String url = result.get("url");
        String fileName = result.get("fileName");

        uploadProfileImageRequestDto.setImageUrl(url);
        uploadProfileImageRequestDto.setImagePath(fileName);

        ProfileImage profileImage = ProfileImage.builder()
                .member(member)
                .imagePath(uploadProfileImageRequestDto.getImagePath())
                .imageUrl(uploadProfileImageRequestDto.getImageUrl())
                .build();
        profileImageRepository.save(profileImage);

        return UploadProfileImageResponseDto.of(profileImage);
    }

    @Transactional
    public Long deleteProfileImage(Member member) {

        ProfileImage profileImage = profileImageRepository.findByMember(member)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_PROFILEIMAGE));

        String imagePath = profileImage.getImagePath();
        s3Service.deleteFile(imagePath);
        profileImageRepository.delete(profileImage);

        return profileImage.getId();
    }

    public List<ProfileImage> getFiles() {
        List<ProfileImage> all = profileImageRepository.findAll();
        return all;
    }

    @Transactional
    public Long saveNickname(Member member, SaveNicknameRequestDto saveNicknameRequestDto) {

        String newNickname = saveNicknameRequestDto.getNickname();

        memberRepository.findByNickname(newNickname)
                .ifPresent((foundedMember) -> {
                    throw new MemberException(MemberErrorInfo.NICKNAME_ALREADY_IN_USE);
                });

        member.setNickname(saveNicknameRequestDto.getNickname());
        memberRepository.save(member);

        return member.getId();
    }

    @Transactional(readOnly = true)
    public SearchMembereResponseDto searchMember(Member loginMember, String keyword) {
        Member searchMember = memberRepository.findByNickname(keyword)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER_BY_NICKNAME));

        Boolean isFriend = friendRepository.existsByMemberIdAndMyFriendId(loginMember.getId(), searchMember.getId());


        return SearchMembereResponseDto.from(searchMember, isFriend);
    }

    @Transactional
    public Long deleteMember(Member member) {
        Long memberId = member.getId();
        memberRepository.deleteById(memberId);

        return memberId;
    }

    @Transactional(readOnly = true)
    public FindMemberSettingResponseDto findMemberSetting(Long loginMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        return new FindMemberSettingResponseDto(loginMember.getNotificationToggle());
    }


    @Transactional
    public Boolean toggleMemberNotification(Long loginMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        loginMember.setNotificationToggle(!loginMember.getNotificationToggle());
        return loginMember.getNotificationToggle();
    }
}
