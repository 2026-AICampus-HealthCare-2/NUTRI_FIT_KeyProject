package com.smhrd.repository;

import com.smhrd.entity.UserSupplement;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserSupplementRepository
        extends JpaRepository<UserSupplement, Long> {

    List<UserSupplement> findByUserIdAndIsActiveTrue(Long userId);
    List<UserSupplement> findByUserId(Long userId);
}