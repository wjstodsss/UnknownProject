package com.unknown.paldak.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.unknown.paldak.admin.common.domain.Criteria;
import com.unknown.paldak.admin.common.domain.PageDTO;
import com.unknown.paldak.admin.common.domain.ReplyVO;
import com.unknown.paldak.admin.domain.QNAVO;
import com.unknown.paldak.admin.service.BaseService;
import com.unknown.paldak.admin.service.QnaReplyServiceImpl;
import com.unknown.paldak.admin.util.FileUploadManager;


import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("admin/qna/*")
@RequiredArgsConstructor
public class QnaController {

	private final BaseService<QNAVO> qnaService;
	private final QnaReplyServiceImpl replyService;
    private final FileUploadManager fileUploadManager;


	
	
	@GetMapping("/list")
	public String list(Criteria cri, Model model) {
		System.out.println("jlkjlkjl");
		System.out.println(cri.getPageNum()+"1321321");
		
		List<ReplyVO> replyList = replyService.getList(cri);
		model.addAttribute("replys", replyList);
		
		List<QNAVO> list = qnaService.getList(cri);
		list.forEach(qnaVO -> System.out.println(qnaVO + "kkkkkkkkkkkkkkkk"));
		model.addAttribute("qnas", list);
		
		//model.addAttribute("pageMaker", new PageDTO(cri, 123)); // 레코드 전체갯수, 13page
        int total = qnaService.getTotal(cri);
        
        model.addAttribute("pageMaker", new PageDTO(cri, total));
        replyList.forEach(replyVO -> System.out.println(replyVO + "z------------zz"));
        return "admin/qna";
	}

	
	@GetMapping("/descList")
	public String descList(Criteria cri, Model model) {
		System.out.println("1");
		System.out.println(cri);
		System.out.println("cricricricrircicicicicicicici" + cri);
		
		List<ReplyVO> replyList = replyService.getList(cri);
		model.addAttribute("replys", replyList);
		
		replyList.forEach(replyVO -> System.out.println(replyVO + "z------------zz"));
		List<QNAVO> list = qnaService.getDescList(cri);
		list.forEach(qnaVO -> System.out.println(qnaVO + "zzzzzzzzzzzzzzzz"));
		list.forEach(qnaVO -> System.out.println(qnaVO));
		model.addAttribute("qnas", list);
		
		//model.addAttribute("pageMaker", new PageDTO(cri, 123)); // 레코드 전체갯수, 13page
        int total = qnaService.getTotal(cri);
        
        model.addAttribute("pageMaker", new PageDTO(cri, total));
        return "admin/qna";
	}
	

	@PostMapping("/register")
	public String register(@RequestParam("uploadFile") MultipartFile[] uploadFile, Model model, QNAVO qnaVO, RedirectAttributes rttr) {
        System.out.println("kkkk");
        if (!uploadFile[0].isEmpty()) { 
			String imageURL = fileUploadManager.uploadFiles(uploadFile);
			qnaVO.setQnaImageURL(imageURL);
		}


	    qnaService.register(qnaVO);
	    System.out.println("kkkfsdfsdfsfsdfk");
	    rttr.addFlashAttribute("result", qnaVO.getQnaId());
	    
	    return "redirect:descList";
	}

	@GetMapping(value = "/get/{qnaId}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Map<String, Object>> get(@PathVariable("qnaId") Long qnaId) {
	    QNAVO qna = qnaService.get(qnaId);
	    System.out.println(qna);
	    ReplyVO reply = replyService.getByQnaId(qnaId); 
	    System.out.println(reply);
	    Map<String, Object> responseData = new HashMap<>();
	    responseData.put("qna", qna);
	    responseData.put("reply", reply);

	    // ResponseEntity에 JSON 데이터 반환
	    return new ResponseEntity<>(responseData, HttpStatus.OK);
	}


	
	@PostMapping("/modify")
	public String modify(MultipartFile[] uploadFile, QNAVO qnaVO, @ModelAttribute("cri") Criteria cri, ReplyVO replyVO, @RequestParam("currentPath") String currentPath, RedirectAttributes rttr) {
        if (!uploadFile[0].isEmpty()) { 
			String imageURL = fileUploadManager.uploadFiles(uploadFile);
			qnaVO.setQnaImageURL(imageURL);
		}

        if(replyVO.getReplyId() == null){
        	System.out.println("------------------------");
        	replyService.register(replyVO);
        }
        replyService.modify(replyVO);
        
	    if (qnaService.modify(qnaVO)) {
	        rttr.addFlashAttribute("result", "success");
	    }
	    
	    rttr.addAttribute("pageNum", cri.getPageNum());
	    rttr.addAttribute("amount", cri.getAmount());
	    return "redirect:" + currentPath;
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("qnaId") Long qnaId, @ModelAttribute("cri") Criteria cri, @RequestParam("currentPath") String currentPath, RedirectAttributes rttr) {
		
		System.out.println("remove..." + qnaId);
		if (qnaService.remove(qnaId)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		System.out.println("remove..." + qnaId);
		return "redirect:" + currentPath;
	}
}