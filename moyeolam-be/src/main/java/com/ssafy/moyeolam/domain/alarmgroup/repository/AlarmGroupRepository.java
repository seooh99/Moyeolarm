package com.ssafy.moyeolam.domain.alarmgroup.repository;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AlarmGroupRepository extends JpaRepository<AlarmGroup, Long> {
    @Query("select a from alarm_group a " +
            "join fetch a.alarmGroupMembers " +
            "where a.id = :id")
    Optional<AlarmGroup> findByIdWithAlarmGroupMembers(@Param("id") Long id);

    @Query("select a from alarm_group a " +
            "join fetch a.hostMember " +
            "where a.id = :id ")
    Optional<AlarmGroup> findByIdWithHostMember(@Param("id") Long id);

    @Query("select a from alarm_group a " +
            "join fetch a.alarmGroupMembers am " +
            "join fetch am.member " +
            "join fetch a.hostMember " +
            "where a.id = :id ")
    Optional<AlarmGroup> findByIdWithHostMemberAndAlarmGroupMembersWithMember(@Param("id") Long id);
}
