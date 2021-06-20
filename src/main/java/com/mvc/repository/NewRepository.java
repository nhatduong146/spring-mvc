package com.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mvc.entity.NewEntity;

public interface NewRepository extends JpaRepository<NewEntity, Long> {
	
}
