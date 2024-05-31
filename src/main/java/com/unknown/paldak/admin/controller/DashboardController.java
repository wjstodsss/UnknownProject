package com.unknown.paldak.admin.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.unknown.paldak.admin.common.domain.Criteria;
import com.unknown.paldak.admin.domain.DashboardVO;
import com.unknown.paldak.admin.service.DashboardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/dashboard/*")
public class DashboardController {

    private final DashboardService dashboardService;
    
    @GetMapping("/main")
	public String list(Criteria cri, Model model) {
    	DashboardVO registrations = dashboardService.getTodayRegistrations();
    	DashboardVO thisMonthRegistrations = dashboardService.getThisMonthRegistrations();
    	DashboardVO dailyOrderCount = dashboardService.getDailyOrderCount();
    	DashboardVO monthlyOrderCount = dashboardService.getMonthlyOrderCount();
    	Integer newItemsCount = dashboardService.getNewItemsCount();
    	Integer totalItemsCount = dashboardService.getTotalItemsCount();
    	Integer reviewCountToday = dashboardService.getReviewCountToday();
    	Integer pendingReviewCount = dashboardService.getPendingReviewCount();
    	Integer qnaCountToday = dashboardService.getQnaCountToday();
    	Integer pendingQnaCount = dashboardService.getPendingQnaCount();
    	Integer itemsNeedOrderCount = dashboardService.getItemsNeedOrderCount();
        Integer totalOrdersCount = dashboardService.getTotalOrdersCount();
        Integer receivedItemsCount = dashboardService.getReceivedItemsCount();
        Integer waitingItemsCount = dashboardService.getWaitingItemsCount();
    	model.addAttribute("todayRegistrations", registrations);
    	model.addAttribute("thisMonthRegistrations", thisMonthRegistrations);
    	model.addAttribute("dailyOrderCount", dailyOrderCount);
    	model.addAttribute("monthlyOrderCount", monthlyOrderCount);
    	model.addAttribute("newItemsCount", newItemsCount);
    	model.addAttribute("totalItemsCount", totalItemsCount);
    	model.addAttribute("reviewCountToday", reviewCountToday);
    	model.addAttribute("pendingReviewCount", pendingReviewCount);
    	model.addAttribute("qnaCountToday", qnaCountToday);
    	model.addAttribute("pendingQnaCount", pendingQnaCount);
    	model.addAttribute("itemsNeedOrderCount", itemsNeedOrderCount);
    	model.addAttribute("totalOrdersCount", totalOrdersCount);
    	model.addAttribute("receivedItemsCount", receivedItemsCount);
    	model.addAttribute("waitingItemsCount", waitingItemsCount);
        return "admin/dashboard";
	}
    
    
    
    
    
    @GetMapping("/todayRegistrations")
    public ResponseEntity<DashboardVO> getTodayRegistrations() {
    	System.out.println("1");
        DashboardVO registrations = dashboardService.getTodayRegistrations();
        System.out.println("2");
        return new ResponseEntity<>(registrations, HttpStatus.OK);
    }

    @GetMapping("/thisMonthRegistrations")
    public ResponseEntity<DashboardVO> getThisMonthRegistrations() {
       DashboardVO registrations = dashboardService.getThisMonthRegistrations();
        return new ResponseEntity<>(registrations, HttpStatus.OK);
    }

    @GetMapping("/dailyOrderCoun")
    public ResponseEntity<DashboardVO> getDailyOrderCount() {
    	System.out.println("1");
        DashboardVO registrations = dashboardService.getDailyOrderCount();
        System.out.println("2");
        return new ResponseEntity<>(registrations, HttpStatus.OK);
    }

    @GetMapping("/monthlyOrderCount")
    public ResponseEntity<DashboardVO> getMonthlyOrderCount() {
       DashboardVO registrations = dashboardService.getMonthlyOrderCount();
        return new ResponseEntity<>(registrations, HttpStatus.OK);
    }
   
}

