package com.smhrd.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smhrd.entity.IntakeLog;

public interface IntakeLogRepository
        extends JpaRepository<IntakeLog, Long> {

    List<IntakeLog> findByIntakeDate(LocalDate intakeDate);

    Optional<IntakeLog> findByScheduleIdAndIntakeDate(
            Long scheduleId,
            LocalDate intakeDate
    );
    List<IntakeLog> findByScheduleIdIn(
            List<Long> scheduleIds
    );
}