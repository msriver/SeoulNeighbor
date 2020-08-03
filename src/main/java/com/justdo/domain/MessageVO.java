package com.justdo.domain;


import lombok.Data;

@Data
public class MessageVO {
	private int mno;
	private String sender;
	private String receiver;
	private String writedate;
	private String message_content;
	private String nickname;
	private char read_check;
}
