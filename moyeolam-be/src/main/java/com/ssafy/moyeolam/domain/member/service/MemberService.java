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

    public void saveProfileImage(Member member, ProfileImageDto profileImageDto) throws IOException {

        String dirName = "profile_image";
        Map<String, String> result = s3Service.uploadFile(profileImageDto.getFile(), dirName);
        String url = result.get("url");
        String fileName = result.get("fileName");

        profileImageDto.setUrl(url);
        ProfileImage profileImagefile = ProfileImage.builder()
                .member(member)
                .imagePath(fileName)
                .imageUrl(profileImageDto.getUrl())
                .build();
        profileImageRepository.save(profileImagefile);
    }

    public void deleteProfileImage(Member member) throws IOException{
        profileImageRepository.findByMember(member)
                        .ifPresent(profileImage -> {
                            String imagePath = profileImage.getImagePath();
                            profileImageRepository.delete(profileImage);
                            // System.out.println("프로필 이미지가 데이터베이스에서 삭제되었습니다.");
                            try {
                                s3Service.deleteFile(imagePath);
                            } catch (Error e) {
                                e.printStackTrace();
                            }
                                }
                        );
    }

    public List<ProfileImage> getFiles() {
        List<ProfileImage> all = profileImageRepository.findAll();
        return all;
    }
}
