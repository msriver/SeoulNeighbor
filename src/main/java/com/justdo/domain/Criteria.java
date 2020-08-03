package com.justdo.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum;
	private int amount;
	private int startIndex;
	
	private String category;
	private String gu;
	
	private String type;
	private String keyword;

	public Criteria() {
		this(1, 20 ,0,null,null);
	}

	public Criteria(int pageNum, int amount, int startIndex,String gu, String category) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.startIndex=startIndex;
		this.gu=gu;
		this.category=category;
	}
	
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
		this.startIndex = (this.pageNum - 1) * this.amount;
		
	}
	
	public String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
	}
	
	public String getListLink() {
		UriComponentsBuilder builder=UriComponentsBuilder.fromPath("")
				.queryParam("pageNum",this.pageNum)
				.queryParam("amount",this.getAmount())
				.queryParam("type",this.getType())
				.queryParam("keyword",this.getKeyword());
		
		return builder.toUriString();
	}
	
}