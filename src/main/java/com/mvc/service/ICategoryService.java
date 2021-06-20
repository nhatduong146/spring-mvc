package com.mvc.service;

import java.util.Map;

import com.mvc.entity.CategoryEntity;

public interface ICategoryService {
	Map<String, String> findAll();
	CategoryEntity FindOneByCode(String code);
}
