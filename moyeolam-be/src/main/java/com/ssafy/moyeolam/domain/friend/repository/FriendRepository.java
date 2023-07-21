package com.ssafy.moyeolam.domain.friend.repository;

import com.ssafy.moyeolam.domain.friend.domain.Friend;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FriendRepository extends JpaRepository<Friend, Long> {
}
