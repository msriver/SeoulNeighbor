package com.justdo.domain;

import lombok.Data;

@Data
public class ReplyVO {
	private int rno;
	private int bno;
	private String reply;
	private String replyer;
	private String replyDate;
	private String updateDate;
	private String member_filename;
	private int exist;
	}

