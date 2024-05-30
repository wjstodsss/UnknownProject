package com.unknown.paldak.admin.service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unknown.paldak.admin.common.domain.Criteria;
import com.unknown.paldak.admin.domain.MemberVO;
import com.unknown.paldak.admin.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements BaseService<MemberVO>{
    
	@Autowired
	private MemberMapper mapper;

	@Override
	public void register(MemberVO memberVO) {
		System.out.println("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
		LocalDateTime now = LocalDateTime.now();
		Date date = Date.from(now.atZone(ZoneId.systemDefault()).toInstant());
		memberVO.setRegDate(date);
		
		mapper.insert(memberVO);
		System.out.println("pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp");
		
	}

	@Override
	public MemberVO get(Long memberId) {
		return mapper.read(memberId);
	}

	@Override
	public boolean modify(MemberVO memberVO) {
		return mapper.update(memberVO)==1;
	}

	@Override
	public boolean remove(Long memberId) {
		return mapper.delete(memberId)==1;
	}

	@Override
	public List<MemberVO> getList(Criteria cri) {
		System.out.println(cri);
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<MemberVO> getDescList(Criteria cri) {
		return mapper.getDescListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	
	public MemberVO getByStringId(String memberId) {
		log.info("get..." + memberId);	
		return mapper.readByStringId(memberId);
	}
	
	public boolean removeByStringId(String memberId) {
		log.info("remove ... " + memberId);
		return mapper.deleteByStringId(memberId)==1;
	}
	
}
