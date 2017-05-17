package com.kabone.research.common.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kabone.research.common.vo.CodeVo;

@Repository(value = "codeMapper")
public interface CodeMapper {
	
	public List<CodeVo> selectCodeList(CodeVo codeVo);

}
