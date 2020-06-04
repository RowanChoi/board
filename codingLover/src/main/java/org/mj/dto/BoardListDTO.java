package org.mj.dto;

import lombok.Data;

@Data
public class BoardListDTO {
	private int bno;
	private String regDateForm;
	private String title;
	private String writer;
	private String category;
	private int hit;
	private int fileCnt;
}
