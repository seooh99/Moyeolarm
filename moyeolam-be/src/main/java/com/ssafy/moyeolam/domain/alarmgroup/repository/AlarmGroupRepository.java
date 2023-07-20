package com.ssafy.moyeolam.domain.alarmgroup.repository;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AlarmGroupRepository extends JpaRepository<AlarmGroup, Long> {
    @Query("select a from alarm_group a " +
            "join fetch a.alarmGroupMembers ")
    List<AlarmGroup> findAllWithAlarmGroupMembersFetch();
}
