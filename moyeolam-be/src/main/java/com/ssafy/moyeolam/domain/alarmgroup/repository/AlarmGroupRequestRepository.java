package com.ssafy.moyeolam.domain.alarmgroup.repository;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AlarmGroupRequestRepository extends JpaRepository<AlarmGroupRequest, Long> {
    Optional<AlarmGroupRequest> findByAlarmGroupIdAndFromMemberIdAndToMemberId(Long alarmGroupId, Long fromMemberId, Long toMemberId);
}
