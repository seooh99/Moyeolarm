package com.ssafy.moyeolam.domain.member.repository;

import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface ProfileImageRepository extends JpaRepository<ProfileImage, Long> {

    @Query("SELECT pi FROM profile_image pi WHERE pi.member = :member")
    Optional<ProfileImage> findByMember(@Param("member") Member member);
}
