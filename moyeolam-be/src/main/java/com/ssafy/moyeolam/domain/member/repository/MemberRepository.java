package com.ssafy.moyeolam.domain.member.repository;

import com.ssafy.moyeolam.domain.member.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {

    Optional<Member> findByOauthIdentifier(String oauthIdentifier);

    @Query("SELECT m FROM member m WHERE m.memberToken.refreshToken = :refreshToken")
    Optional<Member> findByRefreshToken(@Param("refreshToken") String refreshToken);

    @Query("select distinct m from member m " +
            "join fetch m.fcmTokens " +
            "where m.id = :id ")
    Optional<Member> findByIdWithFcmTokens(@Param("id") Long id);

    @Query("SELECT m FROM member m WHERE m.nickname = :nickname")
    Optional<Member> findByNickname(@Param("nickname") String nickname);
}
