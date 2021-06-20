package com.mvc.convertor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mvc.dto.NewDTO;
import com.mvc.entity.NewEntity;
import com.mvc.service.impl.CategoryService;

@Component
public class NewConvertor {
	@Autowired
	private CategoryService categoryService;
	
	public NewDTO toDTO(NewEntity newEntity) {
		NewDTO result = new NewDTO();
		result.setId(newEntity.getId());
		result.setTitle(newEntity.getTitle());
		result.setThumbnail(newEntity.getThumbnail());
		result.setShortDescription(newEntity.getShortDescription());
		result.setCategoryCode(newEntity.getCategory().getCode());
		result.setContent(newEntity.getContent());
		
		return result;
	}
	
	public NewEntity toEntity(NewDTO newDTO) {
		NewEntity result = new NewEntity();
		result.setTitle(newDTO.getTitle());
		result.setThumbnail(newDTO.getThumbnail());
		result.setShortDescription(newDTO.getShortDescription());
		result.setCategory(categoryService.FindOneByCode(newDTO.getCategoryCode()));
		result.setContent(newDTO.getContent());
		
		return result;
	}
	
	public NewEntity toEntity(NewEntity result, NewDTO newDTO) {
		result.setTitle(newDTO.getTitle());
		result.setThumbnail(newDTO.getThumbnail());
		result.setShortDescription(newDTO.getShortDescription());
		result.setCategory(categoryService.FindOneByCode(newDTO.getCategoryCode()));
		result.setContent(newDTO.getContent());
		
		return result;
	}
}
