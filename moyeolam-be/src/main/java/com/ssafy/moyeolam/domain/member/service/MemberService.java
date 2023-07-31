package com.ssafy.moyeolam.domain.member.service;

import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import com.ssafy.moyeolam.domain.member.dto.ProfileImageDto;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import com.ssafy.moyeolam.domain.member.repository.ProfileImageRepository;
import com.ssafy.moyeolam.infra.storage.service.S3Service;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
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

    public void saveProfileImage(Member member, ProfileImageDto profileImageDto) throws IOException {

        String dirName = "profile_image";
        String url = s3Service.uploadFile(profileImageDto.getFile(), dirName);

        profileImageDto.setUrl(url);
        ProfileImage profileImagefile = ProfileImage.builder()
                .member(member)
                .imagePath(profileImageDto.getPath())
                .imageUrl(profileImageDto.getUrl())
                .build();
        profileImageRepository.save(profileImagefile);
    }

    public List<ProfileImage> getFiles() {
        List<ProfileImage> all = profileImageRepository.findAll();
        return all;
    }

}
