package com.justdo.domain;

import lombok.Data;

@Data
public class ReReplyVO {
	private int r_rno;
	private int bno;
	private int rno;
	private String r_reply;
	private String r_replyer;
	private String r_replyDate;
	private String r_updatedate;
	private String member_filename;
}
