package com.ssafy.moyeolam.domain.member.service;

import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import com.ssafy.moyeolam.domain.member.dto.UploadProfileImageRequestDto;
import com.ssafy.moyeolam.domain.member.dto.UploadProfileImageResponseDto;
import com.ssafy.moyeolam.domain.member.exception.MemberErrorInfo;
import com.ssafy.moyeolam.domain.member.exception.MemberException;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import com.ssafy.moyeolam.domain.member.repository.ProfileImageRepository;
import com.ssafy.moyeolam.infra.storage.service.S3Service;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MemberService {
    private final MemberRepository memberRepository;
    private final ProfileImageRepository profileImageRepository;
    private final S3Service s3Service;

    public Optional<Member> findByOauthIdentifier(String username){
        return memberRepository.findByOauthIdentifier(username);
    }

    public UploadProfileImageResponseDto uploadProfileImage(Member member, UploadProfileImageRequestDto uploadProfileImageRequestDto) throws IOException {

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

    public Long deleteProfileImage(Member member){

        ProfileImage profileImage = profileImageRepository.findByMember(member)
                .orElseThrow(()-> new MemberException(MemberErrorInfo.NOT_FOUND_PROFILEIMAGE));

        String imagePath = profileImage.getImagePath();
        s3Service.deleteFile(imagePath);
        profileImageRepository.delete(profileImage);

        return profileImage.getId();
    }

    public List<ProfileImage> getFiles() {
        List<ProfileImage> all = profileImageRepository.findAll();
        return all;
    }
}
