package com.ssafy.moyeolam.domain.member.dto;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
public class UploadProfileImageRequestDto {
    private String imagePath;
    private String imageUrl;
    private MultipartFile file;
}