package com.ssafy.moyeolam.domain.friend.repository;

import com.ssafy.moyeolam.domain.friend.domain.FriendRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FriendRequestRepository extends JpaRepository<FriendRequest, Long> {
    Optional<FriendRequest> findByFromMemberIdAndToMemberId(Long fromMemberId, Long toMemberId);
}
