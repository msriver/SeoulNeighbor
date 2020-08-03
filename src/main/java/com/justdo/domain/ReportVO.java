package com.justdo.domain;

import lombok.Data;

@Data
public class ReportVO {
	private String userid;
	private String rp_content;
	private String rp_type;
	private String rp_group;
	private String rp_target;
	private String rp_regdate;
}
