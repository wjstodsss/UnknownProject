package com.unknown.paldak.admin.mapper;

import com.unknown.paldak.admin.domain.MemberVO;

public interface MemberMapper extends BaseMapper<MemberVO> {
	public MemberVO readByStringId(String id);
	public int deleteByStringId(String id);
}

