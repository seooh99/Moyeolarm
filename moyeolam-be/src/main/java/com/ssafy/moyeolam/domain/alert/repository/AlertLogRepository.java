package com.ssafy.moyeolam.domain.alert.repository;

import com.ssafy.moyeolam.domain.alert.domain.AlertLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AlertLogRepository extends JpaRepository<AlertLog, Long> {
}
