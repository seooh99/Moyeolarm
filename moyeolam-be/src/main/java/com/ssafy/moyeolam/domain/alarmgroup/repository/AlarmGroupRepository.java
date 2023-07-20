package com.ssafy.moyeolam.domain.alarmgroup.repository;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AlarmGroupRepository extends JpaRepository<AlarmGroup, Long> {
}
