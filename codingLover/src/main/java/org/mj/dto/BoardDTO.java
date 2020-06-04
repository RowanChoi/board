package org.mj.dto;

import java.util.List;

import lombok.Data;

@Data
public class BoardDTO {
	private int bno;
	private String regdate;
	private String title;
	private String content;
	private String writer;
	private int hit;
	private int cnt;
	private List<BoardFileDTO> files;
}
