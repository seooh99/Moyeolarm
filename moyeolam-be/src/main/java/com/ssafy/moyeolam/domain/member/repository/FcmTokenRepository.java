package com.ssafy.moyeolam.domain.member.repository;

import com.ssafy.moyeolam.domain.member.domain.FcmToken;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FcmTokenRepository extends JpaRepository<FcmToken, Long> {
    Boolean existsByMemberIdAndFcmTokenAndDeviceIdentifier(Long memberId, String fcmToken, String deviceIdentifier);
}
