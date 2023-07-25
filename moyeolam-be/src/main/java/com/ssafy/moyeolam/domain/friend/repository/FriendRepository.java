package com.ssafy.moyeolam.domain.friend.repository;

import com.ssafy.moyeolam.domain.friend.domain.Friend;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FriendRepository extends JpaRepository<Friend, Long> {
    List<Friend> findAllByMemberId(Long memberId);
    Optional<Friend> findByMemberIdAndMyFriendId(Long memberId, Long myFriendId);

    @Query("select f from friend f " +
            "join fetch f.myFriend fm " +
            "left join fetch fm.profileImage " +
            "where f.member.id = :memberId and fm.nickname like concat('%', :keyword, '%') ")
    List<Friend> findAllByMemberIdAndKeyword(@Param("memberId") Long memberId, @Param("keyword") String keyword);
}
