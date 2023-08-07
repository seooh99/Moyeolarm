package com.ssafy.moyeolam.domain.alarmgroup.repository;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AlarmGroupRequestRepository extends JpaRepository<AlarmGroupRequest, Long> {
    Optional<AlarmGroupRequest> findByAlarmGroupIdAndFromMemberIdAndToMemberId(Long alarmGroupId, Long fromMemberId, Long toMemberId);

    @Query("select a from alarm_group_request a " +
            "join fetch a.toMember m " +
            "where m.id = :toMemberId")
    List<AlarmGroupRequest> findAllByToMemberIdWithToMemberFetch(@Param("toMemberId") Long toMemberId);
}
