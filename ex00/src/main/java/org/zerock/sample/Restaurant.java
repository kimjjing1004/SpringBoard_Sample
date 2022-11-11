package org.zerock.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

//Setter 주입
//생성자 주입
//필드 주입

@Component
@ToString
@RequiredArgsConstructor
public class Restaurant {
	
	private final Chef chef;
}
