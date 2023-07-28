package com.ssafy.moyeolam.domain.friend.repository;

import com.ssafy.moyeolam.domain.friend.domain.FriendRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FriendRequestRepository extends JpaRepository<FriendRequest, Long> {
    Optional<FriendRequest> findByFromMemberIdAndToMemberId(Long fromMemberId, Long toMemberId);

    @Query("select f from  friend_request f " +
            "join fetch f.toMember m " +
            "where m.id = :toMemberId ")
    List<FriendRequest> findAllByToMemberIdWithToMemberFetch(@Param("toMemberId") Long toMemberId);
}
