package com.ssafy.moyeolam.domain.alarmgroup.repository;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupRequest;
import com.ssafy.moyeolam.domain.meta.domain.MetaData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AlarmGroupRequestRepository extends JpaRepository<AlarmGroupRequest, Long> {
    @Query("select case when count(a) > 0 then true else false end " +
            "FROM alarm_group_request a " +
            "WHERE (a.alarmGroup.id = :alarmGroupId and a.fromMember.id = :fromMemberId and a.toMember.id = :toMemberId) " +
            "and (a.matchStatus = :requestStatus or a.matchStatus = :acceptStatus)")
    boolean existsByAlarmGroupIdAndFromMemberIdAndToMemberId(@Param("alarmGroupId") Long alarmGroupId,
                                                             @Param("fromMemberId") Long fromMemberId,
                                                             @Param("toMemberId") Long toMemberId,
                                                             @Param("requestStatus") MetaData requestStatus,
                                                             @Param("acceptStatus") MetaData acceptStatus);
}
