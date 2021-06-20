package com.mvc.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.mvc.dto.NewDTO;

public interface INewService {
	List<NewDTO> findAll(Pageable pageable);
	int getTotalItem();
	NewDTO findById(Long id);
	NewDTO save(NewDTO newDTO);
	void delete(Long id);
}
