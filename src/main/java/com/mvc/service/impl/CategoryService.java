package com.mvc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvc.entity.CategoryEntity;
import com.mvc.repository.CategoryRepository;
import com.mvc.service.ICategoryService;

@Service
public class CategoryService implements ICategoryService{
	
	@Autowired
	private CategoryRepository categoryRepository;

	@Override
	public Map<String, String> findAll() {
		List<CategoryEntity> entities = categoryRepository.findAll();
		Map<String, String> map = new HashMap<>();
		for (CategoryEntity entity : entities) {
			map.put(entity.getCode(), entity.getName());
		}
		return map;
	}

	@Override
	public CategoryEntity FindOneByCode(String code) {
		return categoryRepository.findOneByCode(code);
	}

}
