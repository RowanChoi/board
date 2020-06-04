package org.mj.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private String regdateForm;
	private Date updateDate;
	private int hit;
	private String category;
	private int fileCnt;
}
