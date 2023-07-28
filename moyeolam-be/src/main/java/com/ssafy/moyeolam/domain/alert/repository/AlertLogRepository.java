package com.ssafy.moyeolam.domain.alert.repository;

import com.ssafy.moyeolam.domain.alert.domain.AlertLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AlertLogRepository extends JpaRepository<AlertLog, Long> {

    @Query("select a from alert_log a " +
            "join fetch a.toMember m " +
            "left join fetch a.alarmGroup " +
            "where m.id = :toMemberId ")
    List<AlertLog> findAllByToMemberIdWithDetailsFetch(@Param("toMemberId") Long toMemberId);
}
