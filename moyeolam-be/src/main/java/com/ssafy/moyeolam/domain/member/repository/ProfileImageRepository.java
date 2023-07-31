package com.ssafy.moyeolam.domain.member.repository;

import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProfileImageRepository extends JpaRepository<ProfileImage, Long> {
}
