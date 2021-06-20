package com.mvc.convertor;

import org.springframework.stereotype.Component;

import com.mvc.dto.CategoryDTO;
import com.mvc.entity.CategoryEntity;

@Component
public class CategoryConvertor {
	public CategoryDTO toDTO(CategoryEntity categoryEntity) {
		CategoryDTO categoryDTO = new CategoryDTO();
		categoryDTO.setId(categoryEntity.getId());
		categoryDTO.setCode(categoryEntity.getCode());
		categoryDTO.setName(categoryEntity.getName());
		return categoryDTO;
	}
}
 