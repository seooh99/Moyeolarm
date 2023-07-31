package com.ssafy.moyeolam.domain.member.dto;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
public class ProfileImageDto {
    private String path;
    private String url;
    private MultipartFile file;
}