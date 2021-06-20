package com.mvc.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mvc.convertor.NewConvertor;
import com.mvc.dto.NewDTO;
import com.mvc.entity.NewEntity;
import com.mvc.repository.NewRepository;
import com.mvc.service.INewService;

@Service
public class NewService implements INewService {
	
	@Autowired
	private NewRepository newRepository;
	
	@Autowired
	private NewConvertor newConvertor;
	
	@Override
	public List<NewDTO> findAll(Pageable pageable) {
		List<NewEntity> entities = newRepository.findAll(pageable).getContent();
		List<NewDTO> models = new ArrayList<>();
		for(NewEntity newEntity : entities) {
			NewDTO newDTO = newConvertor.toDTO(newEntity);
			models.add(newDTO);
		}
		return models;
	}

	@Override
	public int getTotalItem() {
		return (int) newRepository.count();
	}

	@Override
	public NewDTO findById(Long id) {
		NewEntity newEntity = newRepository.findOne(id);
		return newConvertor.toDTO(newEntity);
	}

	@Override
	@Transactional
	public NewDTO save(NewDTO newDTO) {
		NewEntity newEntity = new NewEntity();
		if(newDTO.getId() != null) {
			NewEntity oldEntity = newRepository.findOne(newDTO.getId());
			newEntity = newConvertor.toEntity(oldEntity, newDTO);
		}else {
			newEntity = newConvertor.toEntity(newDTO);
		}
		return newConvertor.toDTO(newRepository.save(newEntity));
	}

	@Override
	public void delete(Long id) {
		newRepository.delete(id);
	}
	
	
}
