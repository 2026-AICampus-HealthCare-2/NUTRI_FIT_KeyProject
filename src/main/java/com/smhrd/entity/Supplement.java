package com.smhrd.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "supplements")
@Getter
@Setter
public class Supplement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "supplement_id")
    private Long supplementId;

    @Column(name = "product_name", nullable = false, length = 200)
    private String productName;

    @Column(name = "manufacturer", nullable = false, length = 100)
    private String manufacturer;

    @Column(name = "image_url", nullable = false, length = 500)
    private String imageUrl;

    @Column(
    	    name = "ocr_text",
    	    columnDefinition = "LONGTEXT",
    	    nullable = false
    	)
    	private String ocrText;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;
}