package com.smhrd.repository;

import com.smhrd.entity.Supplement;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SupplementRepository
        extends JpaRepository<Supplement, Long> {
}