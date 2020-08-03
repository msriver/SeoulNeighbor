package com.justdo.domain;

import lombok.Data;

@Data
public class LikeVO {

	private int lno;
	private int bno;
	private String userid;
	private char type;
}
