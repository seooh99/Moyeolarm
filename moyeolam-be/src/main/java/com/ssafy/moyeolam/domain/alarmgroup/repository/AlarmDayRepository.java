package com.ssafy.moyeolam.domain.alarmgroup.repository;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmDay;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AlarmDayRepository extends JpaRepository<AlarmDay, Long> {
}
