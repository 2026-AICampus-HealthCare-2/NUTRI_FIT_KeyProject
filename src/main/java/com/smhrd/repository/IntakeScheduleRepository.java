package com.smhrd.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.smhrd.dto.IntakeScheduleDto;
import com.smhrd.entity.IntakeSchedule;

public interface IntakeScheduleRepository
        extends JpaRepository<IntakeSchedule, Long> {

    List<IntakeSchedule> findByUserSupplementIdAndIsActiveTrue(
            Long userSupplementId
    );
    List<IntakeSchedule> findByUserSupplementIdIn(
            List<Long> userSupplementIds
    );
 // 특정 사용자의 활성화된 모든 복용 일정
    @Query("""
        SELECT s
        FROM IntakeSchedule s
        JOIN UserSupplement us
            ON s.userSupplementId = us.userSupplementId
        WHERE us.userId = :userId
          AND s.isActive = true
        ORDER BY s.intakeTime ASC
    """)
    List<IntakeSchedule> findActiveSchedulesByUserId(
            @Param("userId") Long userId
    );
    
    @Query("""
    	    SELECT new com.smhrd.dto.IntakeScheduleDto(
    	        s.scheduleId,
    	        s.userSupplementId,
    	        sp.productName,
    	        sp.manufacturer,
    	        s.intakeTime,
    	        s.mealRelation,
    	        s.recommendation,
    	        s.isActive
    	    )
    	    FROM IntakeSchedule s
    	    JOIN UserSupplement us
    	        ON s.userSupplementId = us.userSupplementId
    	    JOIN Supplement sp
    	        ON us.supplementId = sp.supplementId
    	    WHERE us.userId = :userId
    	      AND s.isActive = true
    	    ORDER BY s.intakeTime ASC
    	""")
    	List<IntakeScheduleDto> findActiveScheduleDetailsByUserId(
    	        @Param("userId") Long userId
    	);
    List<IntakeSchedule> findByIsActiveTrue();
}