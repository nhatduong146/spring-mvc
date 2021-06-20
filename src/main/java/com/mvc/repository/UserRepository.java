package com.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;


import com.mvc.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
	UserEntity findOneByUserNameAndStatus(String name, int status);
}
