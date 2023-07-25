package com.ssafy.moyeolam.domain.alarmgroup.repository;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AlarmGroupMemberRepository extends JpaRepository<AlarmGroupMember, Long> {

    /**
     * TODO: 추후 정렬 기준이 바뀔수도 있음.
     */
    @Query("select a from alarm_group_member a " +
            "join fetch a.alarmGroup g " +
            "join fetch a.member m " +
            "where m.id = :memberId " +
            "order by a.alarmToggle desc, g.time asc")
    List<AlarmGroupMember> findAllWithAlarmGroupAndMemberByMemberId(@Param("memberId") Long memberId);

    boolean existsByMemberIdAndAlarmGroupId(Long memberId, Long alarmGroupId);

    void deleteByMemberIdAndAlarmGroupId(Long memberId, Long alarmGroupId);

    Optional<AlarmGroupMember> findByAlarmGroupIdAndMemberId(Long alarmGroupId, Long memberId);
}
