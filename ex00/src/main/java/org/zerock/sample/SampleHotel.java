package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

//필드 주입/세터 주입/생성자 주입
@Component
@ToString
@RequiredArgsConstructor
public class SampleHotel {
	
	private final Chef chef;
	
}
