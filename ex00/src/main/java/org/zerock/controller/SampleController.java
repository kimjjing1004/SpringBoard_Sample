package org.zerock.controller;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.SampleDTOList;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {
	
	@RequestMapping("")
	public void basic() {
		
		log.info("basic..........");
	}
	
	@GetMapping("/basicGET")
	public void basicGet() {
		
		log.info("basic get..........");
	}
	
	@GetMapping("/ex00")
	public void ex00(SampleDTO dto) {
		
		log.info(dto);
	}
	
	@GetMapping("/ex01")
	public void ex00(@RequestParam("name") String name, int age) {
		
		log.info(name);
		log.info(age);
	}
	
	@GetMapping("/ex00List")
	public String ex00List(@RequestParam("ids")ArrayList<String> ids) {
		
		log.info("ids: " + ids);
		
		return "ex00List";
	}
	//http://localhost:8080/sample/ex00Bean?list[0].name=AAA&list[0].age=16
	//http://localhost:8080/sample/ex00Bean?list%5B0%5D.name=AAA&list%5B0%5D.age=16
	@GetMapping({"/ex00Bean", "/ex022"})
	public String ex00Bean(@ModelAttribute("sample") SampleDTOList list, Model model) {
		
		log.info(list);
		
		model.addAttribute("result", "success");
		
		return "sample/ex00Bean";
	}
	
	@GetMapping("/re1")
	public String re1() {
		
		log.info("re1...............");
		
		//response.sendRedirect("...");
		return "redirect:/sample/re2";
	}
	
	@GetMapping("/re2")
	public void re2() {
		
		log.info("re2...............");
		
	}
	
	@GetMapping("/exUpload")
	public void exUpload() {
		
		log.info("exUpload..........");
	}
	
	@PostMapping("/exUploadPost")
	public void exUploadPost(ArrayList<MultipartFile> files) {
		
		files.forEach(file -> {
			log.info(file.getOriginalFilename());
			log.info(file.getSize());
			log.info(file.getContentType());
		});
	}
}
