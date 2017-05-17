package com.kabone.research.common.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kabone.research.common.dao.CodeMapper;
import com.kabone.research.common.vo.CodeVo;

@Service(value = "codeService")
public class CodeService {
	@Resource(name = "codeMapper")
	private CodeMapper codeMapper;
	
	private static final Logger logger = LoggerFactory.getLogger(CodeService.class);
	
	public List<CodeVo> selectCodeList(CodeVo codeVo){
		return codeMapper.selectCodeList(codeVo);
	}
}
